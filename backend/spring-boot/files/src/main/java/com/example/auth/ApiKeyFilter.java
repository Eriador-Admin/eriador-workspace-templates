package com.example.auth;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.security.MessageDigest;

/**
 * Simple API-key filter: requires {@code Authorization: Bearer <API_TOKEN>}.
 * Set {@code API_TOKEN} environment variable. Health endpoint is exempt.
 */
@Component
@Order(1)
public class ApiKeyFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Allow health endpoint without auth
        String path = request.getRequestURI();
        if ("/health".equals(path) || "/".equals(path)) {
            chain.doFilter(req, res);
            return;
        }

        String apiToken = System.getenv("API_TOKEN");
        if (apiToken == null || apiToken.isEmpty()) {
            response.setStatus(500);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"API_TOKEN is not configured\"}");
            return;
        }

        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.setStatus(401);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Missing Bearer token\"}");
            return;
        }

        String token = authHeader.substring(7);
        if (!MessageDigest.isEqual(token.getBytes(), apiToken.getBytes())) {
            response.setStatus(401);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Invalid token\"}");
            return;
        }

        chain.doFilter(req, res);
    }
}
