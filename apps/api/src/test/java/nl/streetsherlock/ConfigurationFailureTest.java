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
}
