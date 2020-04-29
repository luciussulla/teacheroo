Rails.application.routes.draw do
		
	resources :students	do 
		resources :tests 
	  #let's see if thi,s will work since tests are also in the techers resource
	end 

	resources :questions
	resources :student_tests
	resources :groups

	resources :teachers do 
	  resources :tests 	do 	
	  	member do 
			get 'remove_q_set'
		end 
	end 
	resources :question_sets
	#no group_tests resouces  
	root "questions#index"
	  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	end
end 
