And /the following articles exist/ do |articles_table|
  Article.destroy_all
  articles_table.hashes.each do |article|
    @article = Article.create!(article)
  end
end

Then /^(?:|I )should not see the merge option$/ do
    expect(page).to have_no_button('Merge')
end

# And /^(?:|I )am on article "([^"]*)"$/ do |article_name|
#     Then %{I should be on "#{article_name}"}
# end
 
Then /^(?:|I )should see the merged article be titled "([^"]*)" or "([^"]*)"$/ do |title1, title2|
  if page.respond_to? :should
    page.should satisfy {|page| page.has_content?(title1) or page.has_content?(title2)}
  else
    assert page.has_content?(title1) or page.has_content?(title2)
  end
    
end

Then /^I should see the new author as "(.+)" or "(.+)"$/ do |a, b|
  if page.respond_to? :should
    page.should satisfy {|page| page.has_content?(a) or page.has_content?(b)}
  else
    assert page.has_content?(a) or page.has_content?(b)
  end
end

Then /^I should see all the comments from "(.+)" and "(.+)"$/ do |a, b|
    article_a = Article.where(title: a).first
    article_b = Article.where(title: b).first
    
    article_a.comments.each do |c|
      Then %{I should see "#{c.body}"}
      Then %{I should see "#{c.author}"}
    end
    
    article_b.comments.each do |c|
      Then %{I should see "#{c.body}"}
      Then %{I should see "#{c.author}"}
    end
end

Then /^I should see the text of both "(.+)" and "(.+)"$/ do |a, b|
  article_a = Article.where(title: a).first
  article_b = Article.where(title: b).first
  Then %{I should see "#{article_a.body}"}
  Then %{I should see "#{article_b.body}"}
end

Given /^I jump to admin$/ do
  visit '/admin'
end

Given /^I am\s*(not)?\s*an admin$/ do |not_admin|
  if not_admin
    visit '/accounts/login'
    fill_in 'user_login', :with => 'nonadmin'
    fill_in 'user_password', :with => 'aaaaaaaa'
    click_button 'Login'
    if page.respond_to? :should
      page.should have_content('Login successful')
    else
      assert page.has_content?('Login successful')
    end
  else
    visit '/accounts/login'
    fill_in 'user_login', :with => 'admin'
    fill_in 'user_password', :with => 'aaaaaaaa'
    click_button 'Login'
    if page.respond_to? :should
      page.should have_content('Login successful')
    else
      assert page.has_content?('Login successful')
    end
  end
end 