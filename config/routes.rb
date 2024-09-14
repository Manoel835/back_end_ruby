Rails.application.routes.draw do
  resources :lists do
    resources :items do
      collection do
        get "by_date/:date", to: "items#by_date", as: "by_date"
      end
    end
  end
end