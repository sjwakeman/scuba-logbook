require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "logbook_secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

  get "/users/:slug" do
    @user = User.find_by_slug(params["slug"])
    erb :"/users/show"
  end

  private

  def authenticate_user
    # if a user is noooooot logged in
    if !logged_in?
      flash[:message] = "You must be logged in to view the page."
      redirect "/login"
    end
  end  
end
