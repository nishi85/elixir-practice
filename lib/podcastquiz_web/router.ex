defmodule PodcastquizWeb.Router do
  use PodcastquizWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PodcastquizWeb do
    pipe_through :browser

    get "/", PageController, :new_quiz
  end

  scope "/auth", PodcastquizWeb do
    pipe_through :browser

    get "/", PageController, :new_quiz

    get "/:provider", SessionController, :request

    get "/google/callback", PageController, :index

    post "/firstQuestion", PageController, :create_quiz

    post "/secondQuestion", PageController, :secondQuestion

    post "/thirdQuestion", PageController, :thirdQuestion

    post "/fourthQuestion", PageController, :fourthQuestion

    post "/fifthQuestion", PageController, :fifthQuestion

    post "/sixthQuestion", PageController, :sixthQuestion

    post "/seventhQuestion", PageController, :seventhQuestion

    post "/finalQuestion", PageController, :finalQuestion

    post "/recommendation", PageController, :recommendation

  end

  # Other scopes may use custom stacks.
  # scope "/api", PodcastquizWeb do
  #   pipe_through :api
  # end
end
