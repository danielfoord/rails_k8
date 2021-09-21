class LogArticlesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    pp Article.all
  end
end
