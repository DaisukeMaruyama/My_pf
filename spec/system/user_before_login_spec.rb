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
      it 'LOG IN/REGSTER リンクが表示される: 左上から4番目のリンクが「LOG IN/REGSTER」である' do
        sign_in_link = find_all('a')[5].native.inner_text
        expect(sign_in_link).to match(/LOG IN/i)
      end
      it 'LOG IN/REGSTERリンクの内容が正しい' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
    end  
    context '遷移先にCreate An Accountリンクがあるかの確認' do  
      before do 
        visit new_user_session_path
      end  
      it 'Create An Accountリンクが表示される' do
        expect(page).to have_link 'Create An Account'
      end
      it 'Create An Accountリンクの内容が正しい' do
        expect(page).to have_link 'Create An Account', href: new_user_registration_path
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
      it 'Homeリンクが表示される: 左上から1番目のリンクが「HOME」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match(/HOME/i)
      end
      it 'SHOPリンクが表示される: 左上から2番目のリンクが「SHOP」である' do
        shop_link = find_all('a')[2].native.inner_text
        expect(shop_link).to match(/SHOP/i)
      end
      it 'SHOPの中にALLリンクが表示される' do
        items_link = find_all('a')[3].native.inner_text
        expect(items_link).to match(/ALL/i)
      end
      it 'Aboutリンクが表示される: 左上から4番目のリンクが「ABOUT」である' do
        about_link = find_all('a')[4].native.inner_text
        expect(about_link).to match(/ABOUT/i)
      end
      it 'LOG IN/REGISTERリンクが表示される: 左上から5番目のリンクが「LOG IN/REGSTER」である' do
        login_link = find_all('a')[5].native.inner_text
        expect(login_link).to match(/LOG IN/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'HOMEを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      #it 'SHOPを押すと、SHOPカテゴリー別リンクがあり遷移できる' do
      #  shop_link = find_all('a')[2].native.inner_text
       # category_link = find_link('Sweets')
      #  is_expected.to eq '/search/genre_search?search%5Bcontent%5D=1'
      #end
      it 'ALLを押すと、製品一覧画面に遷移する' do
        items_link = find_all('a')[3].native.inner_text
        items_link = items_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link items_link
        is_expected.to eq '/items'
      end
      it 'ABOUTを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[4].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'LOGIN/REGISTERを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[5].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
      before do 
        visit new_user_session_path
      end
      it '(画面遷移後)Create An Accountを押すと、 新規登録画面に遷移する' do
        click_link 'Create An Account'
        is_expected.to eq '/users/sign_up'
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
      it '「Register」と表示される' do
        expect(page).to have_content 'Register'
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
      it 'Registerボタンが表示される' do
        expect(page).to have_button 'Register'
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
        expect { click_button 'Register' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Register'
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
      it '「Welcome back!」と表示される' do
        expect(page).to have_content 'Welcome back!'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が画面、Top画面になっている' do
        expect(current_path).to eq '/' 
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

end
