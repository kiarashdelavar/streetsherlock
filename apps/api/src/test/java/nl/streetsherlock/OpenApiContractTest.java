package nl.streetsherlock;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(properties = {
    "streetsherlock.environment=test",
    "springdoc.api-docs.enabled=true"
})
@AutoConfigureMockMvc
class OpenApiContractTest {

    private static final Set<String> HTTP_METHODS = Set.of(
            "get", "put", "post", "delete", "options", "head", "patch", "trace");

    @Autowired
    MockMvc mockMvc;

    @Autowired
    ObjectMapper objectMapper;

    JsonNode committed;
    JsonNode live;

    @BeforeEach
    void loadContracts() throws Exception {
        committed = objectMapper.readTree(Files.readString(contractPath()));
        String response = mockMvc.perform(get("/v3/api-docs").with(jwt()))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andReturn()
                .getResponse()
                .getContentAsString();
        live = objectMapper.readTree(response);
    }

    @Test
    void CONTRACT_001_backendPublishesOpenApi() {
        assertThat(live.path("openapi").asText()).startsWith("3.");
        assertThat(live.path("paths").isObject()).isTrue();
    }

    @Test
    void CONTRACT_002_versionedApiPathsMatchBackendTruth() {
        assertThat(apiPaths(live)).isEqualTo(apiPaths(committed));
    }

    @Test
    void CONTRACT_003_operationIdsMatchBackendTruth() {
        for (String path : apiPaths(committed)) {
            for (String method : methods(committed.path("paths").path(path))) {
                assertThat(live.at("/paths/" + escape(path) + "/" + method)
                        .path("operationId").asText())
                        .as("%s %s operationId", method, path)
                        .isEqualTo(committed.path("paths").path(path).path(method)
                                .path("operationId").asText());
            }
        }
    }

    @Test
    void CONTRACT_004_responseCodesMatchBackendTruth() {
        for (String path : apiPaths(committed)) {
            for (String method : methods(committed.path("paths").path(path))) {
                assertThat(fieldNames(live.path("paths").path(path).path(method)
                        .path("responses")))
                        .as("%s %s responses", method, path)
                        .isEqualTo(fieldNames(committed.path("paths").path(path).path(method)
                                .path("responses")));
            }
        }
    }

    @Test
    void CONTRACT_005_contractContainsSyntheticDataOnly() throws Exception {
        String serialized = objectMapper.writeValueAsString(committed);
        assertThat(serialized)
                .doesNotContain("@")
                .doesNotContain("citizenEmail")
                .doesNotContain("personalData")
                .contains("synthetic");
    }

    @Test
    void CONTRACT_006_problemTypeRemainsUsable() {
        JsonNode required = committed.at("/components/schemas/Problem/required");
        assertThat(required).isNotNull();
        assertThat(required.toString())
                .contains("status", "detail", "correlationId");
        assertThat(committed.at(
                "/components/schemas/Problem/properties/correlationId/format").asText())
                .isEqualTo("uuid");
    }

    private Path contractPath() {
        Path current = Path.of(System.getProperty("user.dir")).toAbsolutePath();
        Path fromRoot = current.resolve("packages/contracts/openapi.json");
        if (Files.exists(fromRoot)) {
            return fromRoot;
        }
        return current.resolve("../../packages/contracts/openapi.json").normalize();
    }

    private Set<String> apiPaths(JsonNode document) {
        Set<String> result = new TreeSet<>();
        document.path("paths").fieldNames().forEachRemaining(path -> {
            if (path.startsWith("/api/")) {
                result.add(path);
            }
        });
        return result;
    }

    private Set<String> methods(JsonNode pathItem) {
        Set<String> result = new TreeSet<>();
        pathItem.fieldNames().forEachRemaining(name -> {
            if (HTTP_METHODS.contains(name)) {
                result.add(name);
            }
        });
        return result;
    }

    private Set<String> fieldNames(JsonNode node) {
        Set<String> result = new TreeSet<>();
        Iterator<String> names = node.fieldNames();
        names.forEachRemaining(result::add);
        return result;
    }

    private String escape(String path) {
        return path.replace("~", "~0").replace("/", "~1");
    }
}
