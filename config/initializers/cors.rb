Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # onde ficara o dominio do front-end
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
