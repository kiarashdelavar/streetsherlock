package nl.streetsherlock.config;

import java.io.IOException;
import java.net.URI;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ProblemDetail;
import org.springframework.stereotype.Component;

@Component
public class ProblemResponseFactory {

    private final ObjectMapper objectMapper;

    public ProblemResponseFactory(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    public ProblemDetail create(HttpStatus status, HttpServletRequest request) {
        ProblemDetail problem = ProblemDetail.forStatusAndDetail(status, safeDetail(status));
        problem.setType(URI.create("about:blank"));
        problem.setTitle(status.getReasonPhrase());
        problem.setProperty("correlationId", correlationId(request));
        return problem;
    }

    public void write(HttpStatus status, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setStatus(status.value());
        response.setContentType(MediaType.APPLICATION_PROBLEM_JSON_VALUE);
        objectMapper.writeValue(response.getOutputStream(), create(status, request));
    }

    private String correlationId(HttpServletRequest request) {
        Object value = request.getAttribute(CorrelationIdFilter.REQUEST_ATTRIBUTE);
        return value instanceof String id ? id : "unavailable";
    }

    private String safeDetail(HttpStatus status) {
        return switch (status) {
            case BAD_REQUEST -> "The request could not be processed.";
            case UNAUTHORIZED -> "Authentication is required.";
            case FORBIDDEN -> "Access is denied.";
            case NOT_FOUND -> "The requested resource was not found.";
            case METHOD_NOT_ALLOWED -> "The request method is not supported.";
            case TOO_MANY_REQUESTS -> "Too many requests.";
            case SERVICE_UNAVAILABLE -> "The service is temporarily unavailable.";
            default -> status.is5xxServerError()
                    ? "An unexpected server error occurred."
                    : "The request could not be completed.";
        };
    }
}
