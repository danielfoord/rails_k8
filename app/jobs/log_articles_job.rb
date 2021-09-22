class LogArticlesJob < ApplicationJob
  queue_as :default

  def perform()
    pp Article.all
  end
end
