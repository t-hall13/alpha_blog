class ArticlesController < ApplicationController
    
    def index
      @articles = Article.all
    end
    
    def new
     @article = Article.new
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def create
       @article = Article.new(article_params)
       if @article.save
           flash[:notice] = "Article was successfully saved"
           redirect_to article_path(@article)
       else
           flash[:warning] = "Something went wrong, please try again"
           render 'new'
       end
    end
    
    def edit
       @article = Article.find(params[:id]) 
    end
    
    def update
       @article = Article.find(params[:id])
       if @article.update(article_params )
           flash[:success] = "Article successfully updated"
           redirect_to article_path(@article)
       else
           flash[:warning] = "Article update failed. Please try again"
           render 'edit'
       end
    end
       
     def destroy
       @article = Article.find(params[:id])
       @article.destroy
       flash[:success] = "Article successfully deleted"
       redirect_to articles_path
     end
    
    
    
    private
    
    def article_params
         params.require(:article).permit(:title, :description)
    end
end