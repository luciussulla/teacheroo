class ApplicationController < ActionController::Base
  private 

  def confirm_log_in
    print "\n inside confirm_log_in\n"
  	unless session[:user_id]
  		flash[:notice] = "Please log in."
  		redirect_to login_path # controller: 'access', action: 'login'
  		return false #halts the action from before action
  	else 
  		return true
  	end 	
  end 

  def current_student
    student = Student.find(session[:user_id])
  end 

  def current_teacher 
    teacher_username = session[:username].to_s
    teacher = Teacher.where(name: teacher_username).first
  end 


=begin
  def check_authorisation(called_user)
   
    if confirm_log_in
      logged_in_user = User.find(session[:user_id])
      #raise logged_in_user.inspect
      print "\n Called user_id #{called_user.id}"
      print "\nLogged in user id is logged_in_user.id\n"
      print "\nIs logged in user a teacher? #{logged_un_user.is_a? Teacher}\n"
      unless (logged_in_user == called_user) #|| !(logged_in_user.is_a? Teacher)
        return false
      end
    else 
      redirect_to login_path 
      return false
    end   
  end 
=end   
end
