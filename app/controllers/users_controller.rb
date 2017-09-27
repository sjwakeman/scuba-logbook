require 'pry'
require 'tux'
require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/' do
    erb :'users/signup'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to "/dives"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || User.find_by(username: params[:username])
      flash[:message] = "An entry field is empty or the Username already exists."
        redirect to "/signup"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
        redirect to "/dives/welcome"
    end
  end

  get '/login' do
  # LOGIN display the form to log in
  if !logged_in?
    erb :'users/login'
  else
    redirect to 'dives/welcome'
  end
end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user[:id]
        redirect to '/dives/welcome'
    else
      flash[:message] = "Please signup before logging in."
        erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
        redirect "/login"
    else
      redirect "/"
    end
  end
end
