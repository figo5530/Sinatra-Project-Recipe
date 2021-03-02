class UsersController < ApplicationController
    get '/signup' do
        if logged_in?
            redirect '/recipes'
        else
            erb :"/users/signup"
        end
    end

    post '/signup' do
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        if @user.id
            session[:user_id] = @user.id
            redirect '/recipes'
        else
            flash[:message] = @user.errors.full_messages
            erb :"/users/signup"
        end
    end
    
    get '/login' do
        erb :"/users/login"
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/recipes'
        else
            flash[:message] = "Invalid Username or Password"
            erb :"/users/login"
        end
    end
end