require 'pry'
require 'tux'

class DivesController < ApplicationController

  get '/dives/welcome' do
    @user = current_user
      erb :'dives/welcome'
  end

  get '/dives/create_dive' do
    if logged_in?
    @user = current_user
      #erb :'dives/create_dive'
      erb :'dives/dive_sheet'
    else
      redirect to '/login'
    end
  end

  get '/dives' do
    if logged_in?
      @dives = current_user.dives
      @user = current_user #displays @user.username on show_dives.erb page
      erb :'dives/show_dives'
    else
      redirect "/login"
    end
  end


 post '/dives' do
   if !logged_in?
     redirect "/login"
   elsif params[:dive_number].empty? || params[:location].empty?
     redirect "/dives/create_dive"
   else
     @dive_number = params[:dive_number]
     @date = params[:date]
     @location = params[:location]
     @visibility = params[:visibility]
     @bottom_time_to_date = params[:bottom_time_to_date]
     @bottom_time_this_dive = params[:bottom_time_this_dive]
     @accumulated_time = params[:accumulated_time]
     @dive_start = params[:dive_start]
     @dive_end = params[:dive_end]
     @dive_comments = params[:dive_comments]
     Dive.create(dive_number: @dive_number, user_id: current_user.id, date: @date, location: @location, visibility: @visibility, bottom_time_to_date: @bottom_time_to_date, bottom_time_this_dive: @bottom_time_this_dive, accumulated_time: @accumulated_time, dive_start: @dive_start, dive_end: @dive_end, dive_comments: @dive_comments)
      redirect "/dives"
   end
 end

 get '/dives/:id' do
   if !logged_in?
     redirect "/login"
   else
     @user = current_user
     @dive = Dive.find(params[:id])
      erb :'dives/show_dive'
   end
 end

 get '/dives/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @user = current_user
      @dive = Dive.find(params[:id])
      if @dive && @user == @dive.user
        erb :'dives/edit_dive'
      else
        redirect to 'dives/create_dive'
      end
    end
  end

  patch '/dives/:id' do
    @user = current_user
    @dive = Dive.find(params[:id])
    @dive_number = params[:dive_number]
    if !logged_in?
      redirect "/login"
    elsif params[:dive_number].empty?
      redirect "/dives/#{@dive.id}/edit"
    else
      @dive_number = params[:dive_number]
      @date = params[:date]
      @location = params[:location]
      @visibility = params[:visibility]
      @bottom_time_to_date = params[:bottom_time_to_date]
      @bottom_time_this_dive = params[:bottom_time_this_dive]
      @accumulated_time = params[:accumulated_time]
      @dive_start = params[:dive_start]
      @dive_end = params[:dive_end]
      @dive_comments = params[:dive_comments]
      @dive.update(dive_number: @dive_number, user_id: current_user.id, date: @date, location: @location, visibility: @visibility, bottom_time_to_date: @bottom_time_to_date, bottom_time_this_dive: @bottom_time_this_dive, accumulated_time: @accumulated_time, dive_start: @dive_start, dive_end: @dive_end, dive_comments: @dive_comments)
        redirect "/dives/#{@dive.id}"
    end
  end

  delete '/dives/:id/delete' do
    @user = current_user
    @dive = Dive.find(params[:id])
    if logged_in? && @dive.user_id == current_user.id
      @dive.destroy
        redirect "/dives"
    #does not let a user delete a dive they did not create
    else
      redirect "/login"
    end
  end
end
