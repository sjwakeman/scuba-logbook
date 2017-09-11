class UsersController < ApplicationController

  get '/' do
    erb :'users/signup'
  end

  get "/signup" do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to "/dives"
    end
  end

  post "/signup" do
    if params[:username] = "" || params[:email] = "" || params[:password] = ""
      redirect to "/login"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/welcome"
    end
  end

  get "/login" do
  # LOGIN display the form to log in
  if !logged_in?
     erb :'users/login'
  else
    redirect 'dives/show_dives'
  end
end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user[:id]
      redirect 'dives/show_dives'
    else
      erb :'users/signup'
    end
  end

  get "/logout" do
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect "/"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params["slug"])
    erb :"/users/show"
  end

end
