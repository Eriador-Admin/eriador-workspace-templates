package handlers

import (
	"sync"

	"github.com/gofiber/fiber/v2"
)

type Item struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

var (
	items     []Item
	mu        sync.Mutex
	idCounter int
)

func ListItems(c *fiber.Ctx) error {
	mu.Lock()
	defer mu.Unlock()
	result := make([]Item, len(items))
	copy(result, items)
	return c.JSON(result)
}

func CreateItem(c *fiber.Ctx) error {
	var item Item
	if err := c.BodyParser(&item); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": err.Error()})
	}
	if item.Name == "" {
		return c.Status(400).JSON(fiber.Map{"error": "name is required"})
	}
	mu.Lock()
	idCounter++
	item.ID = idCounter
	items = append(items, item)
	mu.Unlock()
	return c.Status(201).JSON(item)
}
