defmodule PodcastquizWeb.PageView do
  use PodcastquizWeb, :view


  def take_quiz_button(conn) do
    button("Take Quiz", to: Routes.page_path(conn, :create_quiz ) )
  end

end
