class DivesController < ApplicationController

  get "/dives" do
   if logged_in?
     @dives = Dive.all
     erb :'dives/dives'
   else
     redirect to '/login'
   end
 end

 get '/dives/new' do
   if logged_in?
     erb :'dives/display_dive'
   else
     redirect to '/login'
   end
 end

 post '/dives' do
   if params[:content] == ""
     redirect to "/dives/new"
   else
     @dive = current_user.dives.create(content: params[:content])
     redirect to "/dives/#{@dive.id}"
   end
 end

 get '/dives/:id' do
   if logged_in?
     @dive = Dive.find_by_id(params[:id])
     erb :'dives/display_dive'
   else
     redirect to '/login'
   end
 end

 get '/dives/:id/edit' do
    if logged_in?
      @dive = Dive.find_by_id(params[:id])
      if @dive.user_id == current_user.id
       erb :'dives/edit_dive'
      else
        redirect to '/dives'
      end
    else
      redirect to '/login'
    end
  end

  patch '/dives/:id' do
    if params[:content] == ""
      redirect to "/dives/#{params[:id]}/edit"
    else
      @dive = Dive.find_by_id(params[:id])
      @dive.content = params[:content]
      @dive.save
      redirect to "/dives/#{@dive.id}"
    end
  end

  delete '/dives/:id/delete' do
    if logged_in?
      @dive = Dive.find_by_id(params[:id])
      if @dive.user_id == current_user.id
        @dive.delete
        redirect to '/dives'
      else
        redirect to '/dives'
      end
    else
      redirect to '/login'
    end
  end
end
