Given /^I am a visitor$/ do
end

Given /^I am a logged user$/ do
  @me = FactoryGirl.create :user
  visit new_user_session_path
  fill_login_form(@me)
  click_button "Sign in"
end

When /^I confirm my account$/ do
  @me = User.last
  visit user_confirmation_path(@me, :confirmation_token => @me.confirmation_token)
  visit root_path
end

def fill_login_form(user)
  fill_in("user_email", :with => user.email)
  fill_in("user_password", :with => "password")
end

def fill_register_form(user, mode = nil)
  fill_in("user_username", :with => user.username) unless [:facebook, :twitter].include? mode
  fill_in("user_email", :with => user.email) unless mode == :facebook
  fill_in("user_email_confirmation", :with => user.email) unless mode == :facebook
  fill_in("user_password", :with => user.password)
  fill_in("user_password_confirmation", :with => user.password)
  check_terms_with_js
end

def fill_final_register_form(user)
  fill_in("user_username", :with => user.username)
  check_terms_with_js
end

def fill_register_with_twitter(user)
  fill_in("user_email", :with => user.email)
  fill_in("user_username", :with => user.username)
  check_terms_with_js
end

def check_terms_with_js
  check("terms_and_conditions", visible: true)
end

def logout
  visit user_path(@me)
  first(:link, "Salir").click
end

def login(user)
  visit new_user_session_path
  fill_login_form(user)
  @me = user
  click_button "Entrar"
end

def logout_and_login(user)
  logout
  login(user)
end
