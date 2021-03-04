require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Recipe"
  end

  register Sinatra::Flash

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def plaza
      popular_recipe = Recipe.all.sort_by{|r| -r.save_times}.first
      # random_recipe = Recipe.find_by(author_id: Random.rand(User.all.size-1)) if user deletes one of recipes it could be nil
      @plaza_recipes = Recipe.where.not(id: nil).sample(2)
      @plaza_recipes.unshift(popular_recipe)
    end
  end
end
