require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do

  scenario 'has a new user page' do
    visit "/"
    expect(page).to have_content("Sign Up!!!")
  end

  feature 'signing up a user' do

    scenario 'shows username on user\'s page' do
      sign_up_as_ginger_baker
      ging_id = User.last.id
      expect(page).to have_content('ginger_baker')
      expect(current_path).to eq("/users/#{ging_id}")
    end
  end
end

feature 'logging in' do
  scenario 'has a sign in page' do
    visit new_session_url
    expect(page).to have_content "Sign In"
  end

  scenario 'shows username on user\'s page' do
    sign_up_as_ginger_baker
    click_button 'Sign Out'
    visit new_session_url
    fill_in "Username", with: 'ginger_baker'
    fill_in "Password", with: 'abcdef'
    click_button "Sign In"

    ging_id = User.last.id
    expect(page).to have_content('ginger_baker')
    expect(current_path).to eq("/users/#{ging_id}")
  end
end

feature 'logging out' do
  scenario 'does not show username on homepage after logout' do
    sign_up_as_ginger_baker
    click_button 'Sign Out'
    expect(page).to have_no_content('ginger_baker')
  end
end
