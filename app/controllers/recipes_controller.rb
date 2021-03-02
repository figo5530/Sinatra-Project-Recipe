class RecipesController < ApplicationController
    get '/recipes' do
        if logged_in?
            erb :"/recipes/show"
        else
            redirect '/login'
        end
    end
end