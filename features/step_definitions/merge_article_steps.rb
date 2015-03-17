Given /^the blog is set up with user "([^\"]*)"$/ do |user|
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => user,
                :password => 'aaaaaaaa',
                :email => 'joe1@snow.com',
                :profile_id => 2,
                :name => user,
                :state => 'active'})
end

And /^I am logged in as "([^\"]*)"$/ do |user|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I create article "([^\"]*)" with "([^\"]*)"$/ do |article, content|
	visit '/admin/content/new'
	fill_in "article_title", :with => article
	fill_in "article__body_and_extended_editor", :with => content
	click_button "Publish"
end

And /^I merge "([^\"]*)" and "([^\"]*)"$/ do |article1, article2|
	@article1 = Article.find_by_title(article1)
	@article2 = Article.find_by_title(article2)
	fill_in 'merge_with', :with => @article2.id
	click_button 'Merge'
end

Then /^the author of "([^\"]*)" should be "([^\"]*)"$/ do |article, author|
	@article = Article.find_by_title(article)
	assert(@article.author == author, "Different author.")
end