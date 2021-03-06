class PostsController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def favorites
    @user = current_user
    @posts = @user.favorite_posts.all
  end

  def index
     @posts = unless params[:search].nil?
       Post.search(params[:search]).paginate(page: params[:page], :per_page => 5).find_with_reputation(:votes, :all, order: 'votes desc')
     else
       if params[:tag]
         @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 5)
       else
         @posts = Post.paginate(page: params[:page], :per_page => 5).find_with_reputation(:votes, :all, order: 'votes desc')
       end
     end
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(post_id: :post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def vote
    @post = Post.find(params[:id])
    unless current_user == @post.user
      value = params[:type] == 'up' ? 1 : -1
      @post.add_or_update_evaluation(:votes, value, current_user)
      redirect_to :back, notice: 'Thank you for voting.'
    else
      redirect_to :back, notice: 'You must be logged in.'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list).merge(user_id: current_user.id)
    end
end
