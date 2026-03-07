package com.example.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

@RestController
@RequestMapping("/api/items")
public class ItemController {

    public record CreateItemRequest(String name) {}

    public record ItemResponse(int id, String name) {}

    private final List<ItemResponse> items = new CopyOnWriteArrayList<>();
    private final AtomicInteger idCounter = new AtomicInteger(0);

    @GetMapping
    public List<ItemResponse> list() {
        return items;
    }

    @PostMapping
    public ItemResponse create(@RequestBody CreateItemRequest request) {
        if (request.name() == null || request.name().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "name is required");
        }
        ItemResponse item = new ItemResponse(idCounter.incrementAndGet(), request.name().trim());
        items.add(item);
        return item;
    }
}
