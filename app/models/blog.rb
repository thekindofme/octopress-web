class Blog < ActiveRecord::Base
  attr_accessible :name, :path

  def source_posts_path
    "#{self.path}/source/_posts/"
  end

  def deploy
    `cd #{self.path} && bundle exec rake generate && git add . && git commit -m 'site updated' && git push heroku master > octa.deploy.status`
  end
end
