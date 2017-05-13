class ArticlesController < ApplicationController
  def index
    @title = Article.all
  end
end
