require 'pry'
require 'tux'

class DivesController < ApplicationController

  get '/dives/new' do
    if logged_in?
      erb :'dives/create_dive'
    else
      redirect to 'users/login'
    end
  end

  get "/dives" do
    if logged_in?
      @dives = Dive.all
      @dive = []
        @dives.each do |d|
          @dive << {User.find(d.user_id).username => d.content, user_id: d.user_id, id: d.id}
        end
        @user = User.find(session[:id])
        erb :'dives/show_dives'
    else
      redirect "/users/login"
    end
  end


 post '/dives' do
   if !logged_in?
     redirect "/users/login"
   elsif params[:content].empty?
     redirect "/dives/create_dive"
   else
     @content = params[:content]
     Dive.create(content: @content, user_id: session[:id])
     redirect "dives/show_dives"
   end
 end

 get '/dives/:id' do
   if !logged_in?
     redirect "/users/login"
   else
     @dive = Dive.find_by_id(params[:id])
     erb :'dives/show_dive'
   end
 end

 get '/dives/:id/edit' do
    if !logged_in?
      redirect to 'users/login'
    else
      @dive = current_user.dives.find_by(:id => params[:id])
      if @dive
        erb :'dives/edit_dive'
      else
        redirect to 'dives/create_dive'
      end
    end
  end

  patch '/dives/:id' do
    @dive = current_user.dives.find_by(:id => params[:id])
    @content = params[:content]
    if !logged_in?
      redirect "/users/login"
    elsif params[:content].empty?
      redirect "/dives/#{@tweet.id}/edit"
    else
      @dive.update(content: @content)
      redirect "/dives/#{@dive.id}"
    end
  end

  delete '/dives/:id/delete' do
    @dive = Dive.find_by(:id => params[:id])
    if logged_in? && @dive.user_id == current_user.id
      @dive.destroy
      redirect "dives/show_dives"
    #does not let a user delete a dive they did not create
    elsif !(@dive.user_id == current_user.id)
      redirect "users/login"
    else
      erb :"users/login"

    end
  end
end
