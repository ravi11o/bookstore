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

  scope "/", BookstoreWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BookstoreWeb.Api do
   pipe_through :api

   scope "/books" do
     get "/", BookController, :index
     post "/", BookController, :create
     get "/:id/edit", BookController, :edit
     put "/:id", BookController, :update
     get "/:slug", BookController, :show
     delete "/:id", BookController, :delete
   end
   scope "/categories" do
     get "/", CategoryController, :index
     post "/", CategoryController, :create
     get "/:slug", CategoryController, :show
     get "/:id/:name", CategoryController, :recommended_books
   end
   scope "/persons" do
     get "/", PersonController, :index
     post "/", PersonController, :create
     get "/:slug", PersonController, :show
   end

  end
end
