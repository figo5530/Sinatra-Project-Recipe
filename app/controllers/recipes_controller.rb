class RecipesController < ApplicationController
    get '/recipes/index' do
        if logged_in?
            erb :"/recipes/index", :layout => :layout_1
        else
            redirect '/login'
        end
    end
end