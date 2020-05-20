Rails.application.routes.draw do
	
  
  get 'teacher', 		to: "access#index"
  get 'login', 			to: "access#login", as: :login
  post 'attempt_login', to: "access#attempt_login" # redirects post from login form
  get 'logout', 		to: "access#logout"

  #match ":controller(/:action/(/:id))", via: [:get, :post]

	# this requres namespacing for controllers, maybe do it later
	resources :students	do 
		resources :tests do 
			member do 
				get "take_exam",		to: "student_tests#new", as: :take_exam
				post "complete_exam", 	to: "student_tests#create", as: :complete_exam
				get "results", 			to: "student_tests#results", as: :results
			end 
		end 
	end 

	resources :teachers do 
	   resources :tests do 	
	  	 member do 
		 	get 'remove_q_set'
		 end 
		end  
	end 
	
	resources :questions
	resources :groups
	resources :question_sets

	root to: "groups#index"
end 
