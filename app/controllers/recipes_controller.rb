class RecipesController < ApplicationController
    get '/recipes/index' do
        if logged_in?
            @authored_recipes = current_user.authored_recipes
            @saved_recipes = current_user.saved_recipes
            erb :"/recipes/index", :layout => :layout_1
        else
            redirect '/login'
        end
    end

    get '/recipes/plaza' do
        if logged_in?
            plaza # a helper method in appController to return an array of recipes
            erb :"/recipes/plaza", :layout => :layout_1
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

    post '/recipes' do
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

    #get edit
    get '/recipes/:id/edit' do
        if logged_in?
            @recipe = Recipe.find_by(id: params[:id])
            if @recipe.author_id == current_user.id
                erb :"recipes/edit", :layout => :layout_3
            else
                redirect '/recipes/index'
            end
        else
            redirect '/login'
        end
    end
    
    #patch 
    patch '/recipes/:id' do
        if logged_in?
            @recipe = Recipe.find_by(id: params[:id])
            if @recipe && @recipe.author_id == current_user.id
                @recipe.update(name: params[:name], ingredients: params[:ingredients], cooking_time: params[:cooking_time], level: params[:level], steps: params[:steps])
                redirect "/recipes/#{@recipe.id}"
            else
                redirect '/recipes/index'
            end
        else
            redirect '/login'
        end
    end
    
    #delete
    delete '/recipes/:id/delete' do
        if logged_in?
            @recipe = Recipe.find_by(id: params[:id])
            if @recipe && @recipe.author_id == current_user.id
                @recipe.delete
                redirect "/recipes/index"
            else
                redirect '/recipes/index'
            end
        else
            redirect '/login'
        end
    end

    #save
    post '/recipes/:id/save' do
        if logged_in?
            @recipe = Recipe.find_by(id: params[:id])
            if @recipe && !current_user.saved_recipes.include?(@recipe)
                current_user.saved_recipes << @recipe
                @recipe.save_times += 1
                @recipe.save
                redirect "/recipes/index"
            else
                flash.now[:alert] = "Recipe doesn't exist or has been saved"
            end
        else
            redirect '/login'
        end
    end
end