defmodule HelloPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias HelloPlug.Router

  test "GET /" do
    conn = conn(:get, "/") |> Router.call([])

    assert conn.resp_body == "hello"
  end

  test "GET /:person" do
    conn = conn(:get, "/john.smith") |> Router.call([])

    assert conn.resp_body == "hello john.smith"
  end

  test "POST /:person/:action" do
    conn = conn(:post, "/john.smith/wave") |> Router.call([])

    assert conn.resp_body == "wave at john.smith"
  end

  test "POST /:person/:action with x-www-form-urlencoded" do
    conn =
      conn(:post, "/john.smith/wave")
      |> put_req_header("content-type", "application/x-www-form-urlencoded")
      |> Router.call([])

    assert conn.resp_body == "wave at john.smith"
  end
end
