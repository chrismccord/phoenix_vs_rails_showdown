defmodule Benchmarker.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  scope "/", Benchmarker do
    pipe_through :browser

    get "/:title", PageController, :index
  end
end
