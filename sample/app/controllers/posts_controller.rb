class PostsController < ApplicationController
  def index
    @page_name = "posts"
    posts = Post.all.map do |post|
      DataFormer.new(post)
        .url(:update_url)
        .url(:delete_url)
        .data
    end

    @component_data = {
      posts: posts,
      create_url: posts_path
    }

    render "/react/page"
  end

  def create
    post = Post.new post_params

    save_model(post, "post") do |_post|
      DataFormer.new(_post)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def update
    post = Post.find params[:id]

    update_model(post, post_params, "post") do |_post|
      DataFormer.new(_post)
        .url(:update_url)
        .url(:delete_url)
        .data
    end
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    render :status => 200, :json => {:status => 'success'}
  end

  private
    def post_params
      params.require(:post).permit(:name, :user_id)
    end
end
