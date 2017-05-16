class Article < ApplicationRecord
  def self.news_title(search)
    agent = Mechanize.new
    page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{search}&start=1"
    #page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=이두희&start=1"
    amount = page.search("div.title_desc.all_my span").text
    amount = amount.split("건").last
    amount = amount.split(" / ")
    amount = amount[1].delete(",").to_i
    ### 값이 너무 커지는 
    if amount > 100
      amount = 100
    end
    #arrays = Array.new((99/10)+1){ |i| (i*10)+1 }
    arrays = Array.new((amount/10)+1){ |i| (i)*10 + 1 }
    arrays.each do |index|
      page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{search}&start=#{index}"
      list = page.search("a._sp_each_title").map(&:text)
      list.each do |name|
        articles = Article.create(title: "#{name}")
      end
    end
  end
end
