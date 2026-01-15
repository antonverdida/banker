defmodule BankerWeb.PageController do
  use BankerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
