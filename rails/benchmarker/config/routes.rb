Benchmarker::Application.routes.draw do
  root to: "pages#index"
  get "/:title", to: "pages#index", as: :page
end
