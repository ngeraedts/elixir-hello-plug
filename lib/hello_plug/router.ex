defmodule HelloPlug.Router do
  use Plug.Router

  require Logger

  plug :match
  plug Plug.Parsers, parsers: [:multipart], pass: ["*/*"]
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello")
  end

  get "/:person" do
    %{"person" => person} = conn.params
    send_resp(conn, 200, "hello #{person}")
  end

  post "/:person/:action" do
    %{"person" => person, "action" => action} = conn.params
    send_resp(conn, 200, "#{action} at #{person}")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
