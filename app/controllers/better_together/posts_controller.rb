class BetterTogether::PostsController < ApplicationController
  before_action :set_better_together_post, only: [:show]

  # GET /better_together/posts
  # GET /better_together/posts.json
  def index
    @better_together_posts = BetterTogether::Post.all
  end

  # GET /better_together/posts/1
  # GET /better_together/posts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_better_together_post
      @better_together_post = BetterTogether::Post.friendly.find(params[:id])
    end
end
