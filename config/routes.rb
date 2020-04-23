Rails.application.routes.draw do
	
  	resource :question_sets
	resources :questions
	resources :tests
	root "questions#index"
	
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
