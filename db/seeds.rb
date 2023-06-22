# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

users = [
  { name: 'Tom', email: 'tom@example.com', password: 'password', password_confirmation: 'password', photo: 'Tom.jpg', bio: 'Teacher from Mexico.' },
  { name: 'John', email: 'john@example.com', password: 'password', password_confirmation: 'password', photo: 'John.jpg', bio: 'Software engineer from the USA.' },
  { name: 'Emma', email: 'emma@example.com', password: 'password', password_confirmation: 'password', photo: 'Emma.png', bio: 'Designer from Canada.' }
]

users.each do |user_data|
  user = User.create(user_data)
  (1..3).each do |i|
    post = Post.create(author_id: user.id, title: "Post #{i}", text: "This is post number #{i} by #{user.name}.")
    3.times do
      Comment.create(post_id: post.id, author_id: User.pluck(:id).sample, text: "Testing text.")
    end
  end
end
