require 'rails_helper'

RSpec.describe Post, type: :system do
  before(:each) do
    @user1 = User.create(name: 'Dico Diaz', photo: '/assets/Dico.jpg', bio: 'user bio')
    @post = Post.create(author_id: @user1.id, title: 'post title', text: 'post body')
    @comment = Comment.create(author_id: @user1.id, post: @post, text: 'comment body')
    @comment2 = Comment.create(author_id: @user1.id, post: @post, text: 'comment body 2')
    Like.create(author_id: @user1.id, post: @post)
  end

  describe 'index page' do
    it "shows the user's profile picture" do
      visit user_posts_path(@user1.id)
      expect(page).to have_xpath("//img[contains(@src,'/assets/Dico.jpg')]")
    end

    it "shows the user's username" do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@user1.name)
    end

    it 'shows the number of posts the user has written' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('Number of posts: 1')
    end

    it "shows a post's title" do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post.title)
    end

    it "shows some of the post's body" do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@post.text)
    end

    it 'shows the first comments on a post' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content(@comment.text)
    end

    it 'shows how many comments a post has' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('Comments: 2')
    end

    it 'shows how many likes a post has' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('Likes: 1')
    end

    it "redirects to a post's show page when clicking on it" do
      visit user_posts_path(@user1.id)
      click_link 'View post'
      expect(page).to have_current_path(user_post_path(@user1.id, @post.id))
    end
  end

  describe 'Post show page' do
    it "shows the post's title" do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content(@post.title)
    end

    it 'shows who wrote the post' do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content(@user1.name)
    end

    it 'shows how many comments the post has' do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content('Comments: 2')
    end

    it 'shows how many likes the post has' do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content('Likes: 1')
    end

    it "shows the post's body" do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content(@post.text)
    end

    it 'shows the username of each commentor' do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content(@user1.name)
    end

    it 'shows the comment each commentor left' do
      visit user_post_path(@user1.id, @post.id)
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@comment2.text)
    end
  end
end
