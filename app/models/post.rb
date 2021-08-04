class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  validates :title, presence: true
  validates :body, presence: true

  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.body.scan(/#\w+/)
    hashtags.uniq.each do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      post.tags << tag
    end
  end


  before_update do
    post = Post.find_by(id: self.id)
    post.tags.clear # remove all tags from post when updating it, add it again
    hashtags = self.body.scan(/#\w+/)
    hashtags.uniq.each do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      post.tags << tag
    end
  end
end


