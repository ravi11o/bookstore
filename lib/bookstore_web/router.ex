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
     get "/:slug", BookController, :show
     post "/", BookController, :create
     get "/:id/edit", BookController, :edit
     put "/:id", BookController, :update
     delete "/:id", BookController, :delete
   end
   scope "/categories" do
     get "/", CategoryController, :index
     get "/:slug", CategoryController, :show
     post "/", CategoryController, :create
     get "/:id/edit", CategoryController, :edit
     put "/:id", CategoryController, :update
     delete "/:id", CategoryController, :delete
     get "/:id/:name", CategoryController, :recommended_books
   end
   scope "/persons" do
     get "/", PersonController, :index
     get "/:slug", PersonController, :show
     post "/", PersonController, :create
     get "/:id/edit", PersonController, :edit
     put "/:id", PersonController, :update
     delete "/:id", PersonController, :delete

   end

  end
end
