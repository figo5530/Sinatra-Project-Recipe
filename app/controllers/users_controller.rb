class UsersController < ApplicationController
    get '/signup' do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            redirect "/users/#{@user.slug}"
        else
            erb :"/users/signup"
        end
    end
    
    post '/signup' do
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        if @user.id
            session[:user_id] = @user.id
            session[:username] = @user.username
            redirect "/users/#{@user.slug}"
        else
            flash[:message] = @user.errors.full_messages
            redirect '/signup'
        end
    end
    
    get '/login' do
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            redirect "/users/#{@user.slug}"
        else
            erb :"/users/login"
        end
    end
    
    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            session[:username] = @user.username
            redirect "/users/#{@user.slug}"
        else
            flash[:message] = "Invalid Username or Password"
            redirect '/login'
        end
    end
    
    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :"users/show", :layout => :layout_2
        else
            redirect '/login'
        end
    end
end