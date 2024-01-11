class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :get_article

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.create(comment_params)
    @comment.article_id = params[:article_id]

    respond_to do |format|
      if @comment.save
        CommentMailer.with(comment: @comment).notify_comment.deliver_later

        format.html { redirect_to article_url(@article.id), notice: "Comment was successfully created." }
        format.json { render article_url(@article.id), status: :created, location: @comment }
      else
        format.html { redirect_to article_url(@article.id), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_url(@article.id), notice: "Comment was successfully updated." }
        format.json { render article_url(@article.id), status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to article_url(@article.id), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

      def authorize_user
        begin
          @comment = current_user.comments.find(params[:id])
        rescue
          redirect_to root_url
        end
      end

      def get_article
        @article = Article.find(params[:article_id])
      end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
