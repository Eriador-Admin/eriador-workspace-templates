const express = require("express");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: true }));

// In-memory store
let items = [
  { id: 1, name: "Sample Item", description: "A demo item", done: false },
  { id: 2, name: "Another Item", description: "Another demo item", done: false },
];
let nextId = 3;

// Full page
app.get("/", (req, res) => {
  res.render("index", { title: "{{PROJECT_NAME}}" });
});

// HTML fragment: item list
app.get("/items", (req, res) => {
  res.render("partials/item-list", { items });
});

// HTML fragment: create item
app.post("/items", (req, res) => {
  const { name, description } = req.body;
  if (!name || !name.trim()) {
    return res.render("partials/toast", { message: "Name is required", type: "error" });
  }
  const item = { id: nextId++, name: name.trim(), description: (description || "").trim(), done: false };
  items.push(item);
  res.render("partials/item-list", { items });
});

// HTML fragment: toggle done
app.put("/items/:id/toggle", (req, res) => {
  const item = items.find((i) => i.id === parseInt(req.params.id));
  if (!item) return res.status(404).render("partials/toast", { message: "Not found", type: "error" });
  item.done = !item.done;
  res.render("partials/item-row", { item });
});

// HTML fragment: delete item
app.delete("/items/:id", (req, res) => {
  items = items.filter((i) => i.id !== parseInt(req.params.id));
  res.send("");
});

// HTML fragment: show edit form
app.get("/items/:id/edit", (req, res) => {
  const item = items.find((i) => i.id === parseInt(req.params.id));
  if (!item) return res.status(404).render("partials/toast", { message: "Not found", type: "error" });
  res.render("partials/item-form", { item });
});

// HTML fragment: update item
app.put("/items/:id", (req, res) => {
  const item = items.find((i) => i.id === parseInt(req.params.id));
  if (!item) return res.status(404).render("partials/toast", { message: "Not found", type: "error" });
  const { name, description } = req.body;
  if (name) item.name = name.trim();
  if (description !== undefined) item.description = description.trim();
  res.render("partials/item-row", { item });
});

app.listen(PORT, () => {
  console.log(`{{PROJECT_NAME}} running at http://localhost:${PORT}`);
});
