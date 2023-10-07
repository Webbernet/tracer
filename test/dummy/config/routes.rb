Rails.application.routes.draw do
  mount Tracer::Engine => "/tracer"
end
