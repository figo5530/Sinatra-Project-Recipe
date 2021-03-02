class RecipesController < ApplicationController
    get '/recipes/index' do
        if logged_in?
            erb :"/recipes/index", :layout => :layout_1
        else
            redirect '/login'
        end
    end

    get '/recipes/new' do
        if logged_in?
            erb :"/recipes/new", :layout => :layout_2
        else
            redirect '/login'
        end
    end

    post '/recipes/new' do
        if logged_in?
            @recipe = current_user.authored_recipes.build(name: params[:name], ingredients: params[:ingredients], cooking_time: params[:cooking_time], level: params[:level], steps: params[:steps], save_times: 0)
            @recipe.save
            redirect "/recipes/#{@recipe.id}"
        else
            redirect '/login'
        end
    end

    get '/recipes/:id' do
        if logged_in?
            @recipe = Recipe.find_by(id: params[:id])
            erb :"recipes/show", :layout => :layout_1
        else
            redirect '/login'
        end
    end
end