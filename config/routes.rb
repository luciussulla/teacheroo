Rails.application.routes.draw do
	
resources :question_sets
resources :questions
resources :student_tests
resources :teachers do 
  resources :tests
 end 
resources :groups
  
root "questions#index"
	
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
