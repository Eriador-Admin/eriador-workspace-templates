defmodule AppWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppWeb do
    pipe_through :api

    get "/health", ItemController, :health
    resources "/items", ItemController, except: [:new, :edit]
  end
end
