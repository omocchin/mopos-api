Rails.application.routes.draw do
  mount API => '/'
  mount LetsEncrypt::Engine => '/.well-known'
end
