class ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article created!"
      redirect_to articles_show(@article)
    else
      flash[:danger] = @article.errors.full_messages.join (", ")
      redirect_to new_article_path
    end
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end