Rails.application.routes.draw do
		
	resources :students	do 
		resources :tests do 
			member do 
				get "take_exam", to: "student_tests#new", as: :take_exam
			end 
		end 
	end 
	
	resources :questions
	# the path below is showed on the students/show page and redirects the student 
	# to solve the test.

	#get "studentstests/new/:student_id/:test_id", to: "student_tests#new", as: :take_exam
	# This path is the create path for a new students_tests table entry 
	post "/build", to: "student_tests#create"
	get "studentstests/show/:student_id/:test_id", to: "student_tests#show", as: :show_completed_test

	resources :groups
	
	resources :teachers do 
	   resources :tests do 	
	  	 member do 
		 	get 'remove_q_set'
		 end 
		end  
	end 
	 
	resources :question_sets
	#no group_tests resouces  
	root to: "groups#index"
	#root to: "questions#index"
	  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 
