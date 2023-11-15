class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def new
        @post = Post.new
    end

    def create
        params[:post][:user_id] = current_user.id
        @post = Post.new(post_params)

        if @post.save
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
