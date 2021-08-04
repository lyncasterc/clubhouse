module PostsHelper
  def render_with_hashtags(body)
    body.gsub(/#\w+/) { |word| link_to word, "/posts/hashtag/#{word.delete('#')}" }.html_safe
  end

  def trending_hashtags
    tags = Post.all.sample(200).collect { |post| post.tags }.flatten
    trending_tags = Hash.new(0)
    tags.each {|tag| trending_tags[tag] += 1 }

    trending_tags.sort_by { |tag, count| -count }.take(6).collect {|arr| arr.first.name}
  end
end
