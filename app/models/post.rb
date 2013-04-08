require "stringex"

class Post < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :blog
  after_create :create_post

  extend FriendlyId
  friendly_id :title, use: :slugged

  def preview_url
    "http://localhost:4000/blog/#{self.created_at.strftime('%Y/%m/%d')}/#{self.title.to_url}/"
  end

  def file_name
    "#{self.created_at.strftime('%Y-%m-%d')}-#{self.title.to_url}.markdown"
  end

  def full_path
    "#{self.blog.source_posts_path}#{file_name}"
  end

  def content
    File.read(full_path)
  end

  def content=(new_content)
    file = File.new(full_path, "w")
    file.write(new_content)
    file.close
  end

  private
  def create_post
    open(self.full_path, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: \"#{self.title.gsub(/&/,'&amp;')}\""
      post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
      post.puts "comments: true"
      post.puts "categories: "
      post.puts "---"
    end
  end
end
