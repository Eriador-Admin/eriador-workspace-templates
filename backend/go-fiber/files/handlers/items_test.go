package handlers

import (
	"encoding/json"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/gofiber/fiber/v2"
)

func newApp() *fiber.App {
	app := fiber.New()
	app.Get("/api/items", ListItems)
	app.Post("/api/items", CreateItem)
	return app
}

func TestCreateAndListItems(t *testing.T) {
	app := newApp()

	req := httptest.NewRequest("POST", "/api/items", strings.NewReader(`{"name":"first"}`))
	req.Header.Set("Content-Type", "application/json")
	resp, err := app.Test(req)
	if err != nil {
		t.Fatal(err)
	}
	if resp.StatusCode != 201 {
		t.Fatalf("create: status %d, want 201", resp.StatusCode)
	}

	resp, err = app.Test(httptest.NewRequest("GET", "/api/items", nil))
	if err != nil {
		t.Fatal(err)
	}
	var got []Item
	if err := json.NewDecoder(resp.Body).Decode(&got); err != nil {
		t.Fatal(err)
	}
	if len(got) == 0 || got[len(got)-1].Name != "first" {
		t.Fatalf("list: got %+v", got)
	}
}

func TestCreateItemRequiresName(t *testing.T) {
	app := newApp()
	req := httptest.NewRequest("POST", "/api/items", strings.NewReader(`{}`))
	req.Header.Set("Content-Type", "application/json")
	resp, err := app.Test(req)
	if err != nil {
		t.Fatal(err)
	}
	if resp.StatusCode != 400 {
		t.Fatalf("status %d, want 400", resp.StatusCode)
	}
}
