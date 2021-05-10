require 'rails_helper'

describe '仕上げのテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザ新規登録成功時' do
      visit new_user_registration_path
      fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[email]', with: 'a' + user.email # 確実にuser, other_userと違う文字列にするため
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Register'
      is_expected.to have_content "Welcome! You've successfully created an account."
    end
    it 'ユーザログイン成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      is_expected.to have_content "You're now signed in."
    end
    it 'ユーザログアウト成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      signout_link = find_all('a')[5].native.inner_text
      signout_link = signout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link signout_link
      is_expected.to have_content "You've been signed out."
    end
    it 'ユーザのプロフィール情報更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit edit_user_path(user)
      click_button 'Save'
      is_expected.to have_content 'updated'
    end
  end

end