class AccessController < ApplicationController
  before_action :confirm_log_in, except: [:login, :attempt_login, :logout]

  def index # teacher contrl panel it assumes we only have one teachr
  			# teacher adter loging in should be redirected to his show page
  			# implement the rout for that later
  end

  def login #login form 
  end

  def attempt_login  # accepts post request from login action's login form
  	if params[:username].present? && params[:password].present?
  		# on the login page we can put a hidden field with info
  		# if the login is a teacher or a studnet login then do a contidional 
  		# and pick either a Teacher or a Studnet from the model
  		if params[:user] == 'teacher'
        found_user = Teacher.where(name: params[:username]).first
        print "\n found teacher is #{found_user.inspect}"
      elsif params[:user] == 'student'
        found_user = Student.where(name: params[:username]).first
        print "\n found student is #{found_user.inspect}"
      else
        flash[:notice] = "Please let us know if you are a user or teacher"
        print "\n Neither Student nor Teacher was found \n"
        redirect_to(action: 'login')
        return #otherewise it will not work
      end   

  		if found_user
  			authorized_user = found_user.authenticate(params[:password])
  		end
    else 
      print "\n Password and login was not provided"
      flash[:notice] = "Please provide the password and login"    
  	end 	

	  if authorized_user
	  	session[:user_id] = authorized_user.id
	  	session[:username] = authorized_user.name

      which_login = authorized_user.class == Student ? "student" : "teacher"
      #raise which_login.inspect
      case which_login
      when "teacher"
        flash[:notice] = "You are now logged in as Teacher"
        redirect_to students_path
        return 
      when "student"
        flash[:notice] = "You are now logged in as Student"
        redirect_to student_path(authorized_user) 
        return
      else 
        print "\n There was a problem with the login process\n"
        flash[:notice] = "There was a problem with the login process, please contact the administrator"
        redirect_to login_path
        return 
      end   
	  else 
	  	flash[:notice] = "Invalid username/password combination."
	  	redirect_to :login
      return 
	  end 
  end 

  def logout
  		flash[:notice] = "Logged out"
  		session[:user_id] = nil
	  	session[:username] = nil
  		redirect_to(action: "login")
  end 

	
end
