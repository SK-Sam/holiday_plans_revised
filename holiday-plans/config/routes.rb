Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get '/workers/:id/vacation_requests', to: 'workers#vacation_requests'
    end
  end
end
