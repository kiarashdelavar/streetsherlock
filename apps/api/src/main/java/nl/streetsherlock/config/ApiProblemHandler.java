package nl.streetsherlock.config;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
class ApiProblemHandler extends ResponseEntityExceptionHandler {

    private final ProblemResponseFactory problems;

    ApiProblemHandler(ProblemResponseFactory problems) {
        this.problems = problems;
    }

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(
            Exception exception,
            Object body,
            HttpHeaders headers,
            HttpStatusCode statusCode,
            WebRequest webRequest) {
        HttpServletRequest request = ((ServletWebRequest) webRequest).getRequest();
        HttpStatus status = HttpStatus.resolve(statusCode.value());
        ProblemDetail problem = problems.create(
                status == null ? HttpStatus.INTERNAL_SERVER_ERROR : status,
                request);

        HttpHeaders safeHeaders = new HttpHeaders();
        safeHeaders.setContentType(MediaType.APPLICATION_PROBLEM_JSON);
        return new ResponseEntity<>(problem, safeHeaders, statusCode);
    }

    @ExceptionHandler(AccessDeniedException.class)
    ProblemDetail accessDenied(HttpServletRequest request) {
        return problems.create(HttpStatus.FORBIDDEN, request);
    }
}
