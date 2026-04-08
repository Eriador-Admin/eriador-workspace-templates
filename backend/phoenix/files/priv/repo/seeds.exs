# priv/repo/seeds.exs
# Run with: mix run priv/repo/seeds.exs

alias App.{Repo, Item}

items = [
  %{name: "First Item", description: "A sample item", status: "active"},
  %{name: "Second Item", description: "Another sample item", status: "active"}
]

for attrs <- items do
  %Item{}
  |> Item.changeset(attrs)
  |> Repo.insert!()
end

IO.puts("Seeded #{length(items)} items")
