require 'pry'
require 'tux'
require 'rack-flash'

class DivesController < ApplicationController
  use Rack::Flash

  get '/dives/welcome' do
    @user = current_user
      erb :'dives/welcome'
  end

  get '/dives/create_dive' do
    if logged_in?
    @user = current_user
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
   @user = current_user
   @dive = Dive.find(params[:id])
   if !logged_in?
     redirect "/login"
  elsif @dive.user_id != current_user.id
    redirect "/dives"
   else
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
        redirect to '/dives'
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
flash[:message] = "Dive was updated confirmation."
        redirect "/dives/#{@dive.id}"
    end
  end

  delete '/dives/:id/delete' do
    @user = current_user
    @dive = Dive.find(params[:id])
    if logged_in? && @dive.user_id == current_user.id
      @dive.destroy
        flash[:message] = "Dive was deleted confirmation."
        redirect "/dives"
    #does not let a user delete a dive they did not create
    else
      flash[:message] = "You have unauthorized access to this dive."
      redirect "/login"
    end
  end
end
