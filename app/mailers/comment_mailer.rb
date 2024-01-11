class CommentMailer < ApplicationMailer
  default from: 'notifications@railsblog.com'

  def notify_comment
    @comment = params[:comment]
    mail(to: @comment.article.user.email, subject: 'New comment in your article!')
  end
end
