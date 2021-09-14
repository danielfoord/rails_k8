class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      prepend_view_path "articles/new"
      render :action => :new, :path => "articles/new"
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
