class Admin::BetterTogether::PostsController < Admin::AdminController
  before_action :set_better_together_post, only: [:show, :edit, :update, :destroy]

  # GET /better_together/posts
  # GET /better_together/posts.json
  def index
    @better_together_posts = BetterTogether::Post.all
  end

  # GET /better_together/posts/1
  # GET /better_together/posts/1.json
  def show
  end

  # GET /better_together/posts/new
  def new
    @better_together_post = BetterTogether::Post.new
  end

  # GET /better_together/posts/1/edit
  def edit
  end

  # POST /better_together/posts
  # POST /better_together/posts.json
  def create
    @better_together_post = BetterTogether::Post.new(better_together_post_params)

    respond_to do |format|
      if @better_together_post.save
        format.html { redirect_to edit_admin_better_together_post_path(@better_together_post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @better_together_post }
      else
        format.html { render :new }
        format.json { render json: @better_together_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /better_together/posts/1
  # PATCH/PUT /better_together/posts/1.json
  def update
    respond_to do |format|
      if @better_together_post.update(better_together_post_params)
        format.html { redirect_to edit_admin_better_together_post_path(@better_together_post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @better_together_post }
      else
        format.html { render :edit }
        format.json { render json: @better_together_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /better_together/posts/1
  # DELETE /better_together/posts/1.json
  def destroy
    @better_together_post.destroy
    respond_to do |format|
      format.html { redirect_to admin_better_together_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_better_together_post
      @better_together_post = BetterTogether::Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def better_together_post_params
      params.require(:better_together_post).permit(:bt_id, :title, :content, :slug)
    end
end
