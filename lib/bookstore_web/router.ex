defmodule BookstoreWeb.Router do
  use BookstoreWeb, :router

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

  pipeline :api_auth do
    plug BookstoreWeb.Pipeline
  end

  scope "/", BookstoreWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1/admin", BookstoreWeb.Api do
    pipe_through :api
    post "/login", AuthController, :create
    get "/me", AuthController, :info

    scope "/" do
      pipe_through :api_auth

      scope "/books" do
        get "/", BookController, :index
        get "/:id", BookController, :show
        post "/", BookController, :create
        get "/:id/edit", BookController, :edit
        put "/:id", BookController, :update
        delete "/:id", BookController, :delete
      end
      scope "/categories" do
        get "/", CategoryController, :index
        get "/:id", CategoryController, :show
        post "/", CategoryController, :create
        get "/:id/edit", CategoryController, :edit
        put "/:id", CategoryController, :update
        delete "/:id", CategoryController, :delete
      end
      scope "/persons" do
        get "/", PersonController, :index
        get "/:id", PersonController, :show
        post "/", PersonController, :create
        get "/:id/edit", PersonController, :edit
        put "/:id", PersonController, :update
        delete "/:id", PersonController, :delete
      end
    end
  end

  scope "/api/v1", BookstoreWeb.Api do
    pipe_through :api

    get "/recommended-books", BookController, :recommended_books
    scope "/books" do
      get "/", BookController, :index
      get "/:slug", BookController, :show_slug
    end
    scope "/categories" do
      get "/", CategoryController, :index
      get "/:slug", CategoryController, :show_slug
      get "/:id/:name", CategoryController, :recommended_books
    end
    scope "/persons" do
      get "/", PersonController, :index
      get "/:slug", PersonController, :show_slug
    end

  end
end
