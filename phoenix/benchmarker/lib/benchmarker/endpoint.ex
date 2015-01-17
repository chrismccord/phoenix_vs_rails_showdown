defmodule Benchmarker.Endpoint do
  use Phoenix.Endpoint, otp_app: :benchmarker

  plug Plug.Static,
    at: "/", from: :benchmarker

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_benchmarker_key",
    signing_salt: "UU4/F5b7",
    encryption_salt: "9R4y+niH"

  plug :router, Benchmarker.Router
end
