class ArticlesController < ApplicationController
  
  before_action :authenticate_user! #ログインをしてなかったら新規登録画面に飛ばす
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:show, :edit, :update, :destroy]#articles/番号で他の人の投稿が見れないようにする

  
  def index
    @articles = current_user.articles.order(created_at: :desc)
  end

  def show
   
  end

  def new
    @article = Article.new
  end

  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] ="作成しました"
      redirect_to @article
    else
      flash.now[:alert] = "作成できませんでした"
      render 'new'
    end

  end
  
  def update
  end
  
  def destroy
    if @article.destroy
      flash.now[:notice]="削除しました"
      redirect_to root_path
    else
      flash[:alert]="削除できませんでした"
      
    end
  end

 
 private
  
  def find_article
     @article = Article.find(params[:id])
  end
 
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
  def validate_user
    if @article.user != current_user
      redirect_to root_path
      flash[:alert] = "あなたの投稿ではありません"
      
  end
 end

end
