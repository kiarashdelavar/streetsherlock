package nl.streetsherlock.config;

import java.net.URI;
import java.util.Set;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
final class IdentityEnvironmentBoundary {

    private static final Set<String> DEVELOPMENT_ENVIRONMENTS = Set.of("local", "test");

    private final RuntimeProperties runtimeProperties;
    private final URI jwkSetUri;

    IdentityEnvironmentBoundary(
            RuntimeProperties runtimeProperties,
            @Value("${spring.security.oauth2.resourceserver.jwt.jwk-set-uri}") URI jwkSetUri) {
        this.runtimeProperties = runtimeProperties;
        this.jwkSetUri = jwkSetUri;
    }

    @PostConstruct
    void rejectLocalIdentityOutsideDevelopment() {
        String environment = runtimeProperties.environment().trim().toLowerCase();
        String host = jwkSetUri.getHost();
        boolean loopbackIdentity = "127.0.0.1".equals(host) || "localhost".equals(host);

        if (!DEVELOPMENT_ENVIRONMENTS.contains(environment) && loopbackIdentity) {
            throw new IllegalStateException(
                    "Local dev identity is forbidden outside local/test; configure OIDC_JWK_SET_URI");
        }
    }
}
