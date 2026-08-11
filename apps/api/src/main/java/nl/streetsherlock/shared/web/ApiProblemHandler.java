package nl.streetsherlock.shared.web;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ResponseStatusException;

@RestControllerAdvice
class ApiProblemHandler {

    private final ProblemResponseFactory problems;

    ApiProblemHandler(ProblemResponseFactory problems) {
        this.problems = problems;
    }

    @ExceptionHandler(ResponseStatusException.class)
    ProblemDetail responseStatus(ResponseStatusException exception, HttpServletRequest request) {
        HttpStatus status = HttpStatus.resolve(exception.getStatusCode().value());
        return problems.create(status == null ? HttpStatus.INTERNAL_SERVER_ERROR : status, request);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    ProblemDetail invalidRequest(HttpServletRequest request) {
        return problems.create(HttpStatus.BAD_REQUEST, request);
    }

    @ExceptionHandler(AccessDeniedException.class)
    ProblemDetail accessDenied(HttpServletRequest request) {
        return problems.create(HttpStatus.FORBIDDEN, request);
    }
}
