require 'pry'
require 'tux'

class DivesController < ApplicationController

  get '/dives/welcome' do
    @user = User.find(session[:user_id])
      erb :'dives/welcome'
  end

  get '/dives/create_dive' do
    if logged_in?
    @user = User.find(session[:user_id])
      #erb :'dives/create_dive'
      erb :'dives/dive_sheet'
    else
      redirect to 'users/login'
    end
  end

  #get '/show_dives' do
  get '/dives' do
    if logged_in?
      @dives = Dive.all
      @dive = []
      @user = User.find(session[:user_id]) #displays @user.username on show_dives.erb page
        erb :'dives/show_dives'
    else
      redirect "/login"
    end
  end


 post '/dives' do
   if !logged_in?
     redirect "/users/login"
   elsif params[:content].empty?
     @user = User.find(session[:user_id])
     redirect "/dives/create_dive"
   else
     @user = User.find(session[:user_id])
     @content = params[:content]
     Dife.create(content: @content, user_id: session[:user_id])
     redirect "dives/show_dives"
   end
 end

 get '/dives/:id' do
   if !logged_in?
     redirect "/users/login"
   else
     @user = User.find(session[:user_id])
     @dive = Dive.all.find_by_id(params[:user_id])
     erb :'dives/show_dive'
   end
 end

 get '/dives/:id/edit' do
    if !logged_in?
      redirect to 'users/login'
    else
      @user = User.find(session[:user_id])
      @dive = current_user.dives.find_by(:user_id => params[:user_id])
      if @dive
        erb :'dives/edit_dive'
      else
        @user = User.find(session[:user_id])
        redirect to 'dives/create_dive'
      end
    end
  end

  patch '/dives/:id' do
    @user = User.find(session[:user_id])
    @dive = current_user.dives.find_by(:user_id => params[:user_id])
    @content = params[:content]
    if !logged_in?
      redirect "/users/login"
    elsif params[:content].empty?
      redirect "/dives/#{@dive.id}/edit"
    else
      @dive.update(content: @content)
      redirect "/dives/#{@dive.id}"
    end
  end

  delete '/dives/:id/delete' do
    @user = User.find(session[:user_id])
    @dive = Dive.find_by(:user_id => params[:user_id])
    if logged_in? && @dive.user_id == current_user.user_id
      @dive.destroy
      redirect "dives/show_dives"
    #does not let a user delete a dive they did not create
  elsif !(@dive.user_id == current_user.user_id)
      redirect "dives/show_dives"
    else
      erb :"users/login"

    end
  end
end
