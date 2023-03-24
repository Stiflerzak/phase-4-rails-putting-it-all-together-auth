class RecipesController < ApplicationController
    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipes= Recipe.all
            render json: recipes, status: :ok
        else
            render json: {error: "You must be logged in to view recipes"}, status: :unauthorized
        end
    end

    def create
        user= User.find_by(id: session[:user_id])
        if user
            recipe= Recipe.new(recipe_params) 
            recipe.user_id = user.id

            if recipe.save
                render json: recipe, status: :created
            else
                render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "You must be logged in to create a recipe" }, status: :unauthorized
    end

    end

    private
    def recipe_params
        params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
end
