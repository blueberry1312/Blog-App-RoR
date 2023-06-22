require 'rails_helper'
RSpec.describe User, type: :system do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: '/assets/Tom.jpg', bio: 'Mock bio', email: 'example@example.com',
                         password: 'password')
    @user2 = User.create(name: 'Emma', photo: '/assets/Emma.png', bio: 'Mock bio 2', email: 'example@example.com',
                         password: 'password')
  end

  describe 'index page' do
    it 'shows the username for all users' do
      visit users_path
      expect(page).to have_content('Tom')
    end

    it 'shows the profile picture for each user' do
      visit users_path
      expect(page).to have_xpath("//img[contains(@src,'assets/Tom.jpg')]")
    end

    it 'shows the number of posts for each user' do
      visit users_path
      expect(page).to have_content('Number of posts: 0')
      Post.create(author_id: @user1.id, title: 'Title', text: 'text')
      Post.create(author_id: @user1.id, title: 'Title2', text: 'text2')
      visit users_path
      expect(page).to have_content('Number of posts: 2')
    end

    it "redirects to a user show page when clicking on it's card" do
      visit users_path
      click_link(@user1.name)
      expect(page).to have_current_path(user_path(@user1.id))
    end
  end

  describe 'show page' do
    before(:each) do
      Post.create(author_id: @user1.id, title: 'textitle', text: 'text')
      visit user_path(@user1)
    end

    it 'displays the user profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'assets/Tom.jpg')]")
    end

    it 'displays the user username' do
      expect(page).to have_content(@user1.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 1')
    end

    it 'displays the user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'displays the first 3 posts' do
      Post.where(author_id: @user1.id).each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'displays a button to view all of a user\'s posts' do
      expect(page).to have_link('See all posts', href: user_posts_path(@user1))
    end

    it 'redirects to the post show page when a post is clicked' do
      post = Post.where(author_id: @user1.id).first
      click_link 'View post'
      expect(page).to have_current_path(user_post_path(@user1, post))
    end

    it 'redirects to the user posts index page when "See all posts" is clicked' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
