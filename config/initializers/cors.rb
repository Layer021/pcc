Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # TODO: SPAのURLを指定
    origins "*"

    resource "/api/*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
