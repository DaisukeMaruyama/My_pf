require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Sign inリンクが表示される: 左上から4番目のリンクが「Sign in」である' do
        sign_in_link = find_all('a')[6].native.inner_text
        expect(sign_in_link).to match(/Sign in/i)
      end
      it 'Sign inリンクの内容が正しい' do
        log_in_link = find_all('a')[6].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'Sign Upリンクが表示される: 左上から5番目のリンクが「Sign Up」である' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/sign up/i)
      end
      it 'Sign Upリンクの内容が正しい' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'SnackBen'
      end
      it 'Homeリンクが表示される: 左上から1番目のリンクが「Home」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match(/Home/i)
      end
      it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
        about_link = find_all('a')[2].native.inner_text
        expect(about_link).to match(/About/i)
      end
      it 'Aboutリンクが表示される: 左上から3番目のリンクが「Snacks」である' do
        genre_name_link = find_all('a')[3].native.inner_text
        expect(genre_name_link).to match(/Snacks/i)
      end
      it 'Aboutリンクが表示される: 左上から4番目のリンクが「View all」である' do
        view_all_link = find_all('a')[4].native.inner_text
        expect(view_all_link).to match(/View all/i)
      end
      it 'sign upリンクが表示される: 左上から5番目のリンクが「Sign up」である' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/Sign up/i)
      end
      it 'sign inリンクが表示される: 左上から6番目のリンクが「Sign in」である' do
        sign_in_link = find_all('a')[6].native.inner_text
        expect(sign_in_link).to match(/Sign in/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Homeを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it 'Aboutを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[2].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'sign upを押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[5].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'Sign inを押すと、ログイン画面に遷移する' do
        signin_link = find_all('a')[6].native.inner_text
        signin_link = signin_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signin_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'first_nameフォームが表示される' do
        expect(page).to have_field 'user[first_name]'
      end
      it 'last_nameフォームが表示される' do
        expect(page).to have_field 'user[last_name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Signup'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Signup' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Signup'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「Sign in」と表示される' do
        expect(page).to have_content 'Sign in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Sign inボタンが表示される' do
        expect(page).to have_button 'Signin'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Signin'
      end

      it 'ログイン後のリダイレクト先が画面、Top画面になっている' do
        expect(current_path).to eq '/' 
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Signin'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Signin'
    end

    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'SnackBen'
      end
      it 'Homeリンクが表示される: 左上から1番目のリンクが「Home」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match(/home/i)
      end
      it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
        about_link = find_all('a')[2].native.inner_text
        expect(about_link).to match(/about/i)
      end
      it 'Aboutリンクが表示される: 左上から3番目のリンクが「Snacks」である' do
        genre_name_link = find_all('a')[3].native.inner_text
        expect(genre_name_link).to match(/Snacks/i)
      end
      it 'Aboutリンクが表示される: 左上から4番目のリンクが「View all」である' do
        view_all_link = find_all('a')[4].native.inner_text
        expect(view_all_link).to match(/View all/i)
      end
      it 'Sign outリンクが表示される: 左上から5番目のリンクが「Sign out」である' do
        sign_out_link = find_all('a')[5].native.inner_text
        expect(sign_out_link).to match(/sign out/i)
      end
      it 'Cartリンクが表示される: 左上から6番目のリンクが「Cart」である' do
        cart_link = find_all('a')[6].native.inner_text
        expect(cart_link).to match(/cart/i)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Signin'
      sign_out_link = find_all('a')[5].native.inner_text
      sign_out_link = sign_out_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link sign_out_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
