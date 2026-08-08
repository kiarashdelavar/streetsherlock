package nl.streetsherlock;

import nl.streetsherlock.config.RuntimeProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(RuntimeProperties.class)
public class StreetSherlockApplication {

    public static void main(String[] args) {
        SpringApplication.run(StreetSherlockApplication.class, args);
    }
}
