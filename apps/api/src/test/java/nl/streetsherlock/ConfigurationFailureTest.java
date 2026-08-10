package nl.streetsherlock;

import org.junit.jupiter.api.Test;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.builder.SpringApplicationBuilder;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class ConfigurationFailureTest {

    @Test
    void missingEnvironmentFailsClosedWithActionableConfigurationError() {
        assertThatThrownBy(() -> new SpringApplicationBuilder(StreetSherlockApplication.class)
                .web(WebApplicationType.NONE)
                .properties("streetsherlock.environment=")
                .run()
                .close())
                .hasMessageContaining("Unable to bind");
    }

    @Test
    void demoEnvironmentCannotSilentlyUseLocalIdentity() {
        assertThatThrownBy(() -> new SpringApplicationBuilder(StreetSherlockApplication.class)
                .web(WebApplicationType.NONE)
                .properties(
                        "streetsherlock.environment=demo",
                        "spring.security.oauth2.resourceserver.jwt.jwk-set-uri="
                                + "http://127.0.0.1:8180/realms/streetsherlock-dev/"
                                + "protocol/openid-connect/certs")
                .run()
                .close())
                .hasRootCauseMessage(
                        "Local dev identity is forbidden outside local/test; "
                                + "configure OIDC_JWK_SET_URI");
    }
}
