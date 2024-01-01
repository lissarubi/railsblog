class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all.includes(:user)
  end

  # GET /articles/1 or /articles/1.json
  def show
      @article = Article.find(params[:id])
      @comments = @article.comments
      @article.increment! :views, 1

      @comment = Comment.new
      @comment.article_id = @article.id
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
      old_article = Article.find(params[:id])
      article_to_compare = Article.new(article_params)

        respond_to do |format|
      if compare_articles_content old_article, article_to_compare
        @article.edited = true

          if @article.update(article_params)
            format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
            format.json { render :show, status: :ok, location: @article }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
      else
            format.html { redirect_to article_url(@article), notice: "Article hasn't any change." }
            format.json { render :show, status: :ok, location: @article }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
      def authorize_user
        begin
          @article = current_user.articles.find(params[:id])
        rescue
          redirect_to root_url
        end
      end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def compare_articles_content(a1, a2)
      a1.body != a2.body || a1.title != a2.title
    end
end