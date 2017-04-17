class AuthenticationController < ApplicationController

  before_action: logged_in?

	def home
    puts"#{session[:user_id]}"
		if session[:user_id]==nil
      puts"not logged in"
			return redirect_to '/signin'
		end
    @user = User.find(session[:user_id])
	end

def signin_get
end

def signup_get
end


  def signin
  	email = params[:email]
  	password = params[:password]
  	user = User.find_by_email(email)
  	if user
  		if password == user.password
  			session[:user_id]=user.id

  			redirect_to '/' 
  		else
  			redirect_to '/signin'
  		end
  	else
  		redirect_to '/signup'
  	end
  end

  def signup
  	email = params[:email]
  	user = User.find_by_email(email)
  	if user
  		redirect_to '/signup'
  	else
  		password = params[:password]
  		user = User.create(email: email, password: password)
  		session[:user_id] = user.id
  		redirect_to '/'
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to '/signin'
  end
end
