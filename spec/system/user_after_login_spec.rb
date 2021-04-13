require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

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
    it 'Snacksリンクが表示される: 左上から3番目のリンクが「Snacks」である' do
      genre_name_link = find_all('a')[3].native.inner_text
      expect(genre_name_link).to match(/Snacks/i)
    end
    it 'View allリンクが表示される: 左上から4番目のリンクが「View all」である' do
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


describe 'ヘッダーのテスト: ログインしている場合' do
  context 'リンクの内容を確認: ※signoutは『ユーザログアウトのテスト』でテスト済み。' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Signin'
    end
    subject { current_path }

    it 'Homeを押すと、Top画面に遷移する' do
      home_link = find_all('a')[1].native.inner_text
      home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link home_link
      is_expected.to eq '/'
    end
    it 'Aboutを押すと、About画面に遷移する' do
      about_link = find_all('a')[2].native.inner_text
      about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link about_link
      is_expected.to eq '/about'
    end
    it 'Snacksを押すと、Snacksジャンル別画面に遷移する' do
      genre_name_link = find_all('a')[3].native.inner_text
      genre_name_link = genre_name_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link genre_name_link
      is_expected.to eq '/'
    end
    it 'View allを押すと、items画面に遷移する' do
      view_all_link = find_all('a')[4].native.inner_text
      view_all_link = view_all_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link view_all_link
      is_expected.to eq '/items'
    end
    it 'Cartを押すと、Cart画面に遷移する' do
      cart_link = find_all('a')[6].native.inner_text
      cart_link = cart_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link cart_link
      is_expected.to eq '/cart_items'
    end
  end
end

describe '自分のユーザ詳細画面のテスト' do
  let(:user) { create(:user) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Signin'
    visit user_path(user)
  end
    
  context '表示の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/users/' + user.id.to_s
    end
  end

  context 'マイページの確認' do
    it '自分の名前とemailが表示される' do
      expect(page).to have_content user.last_name
      expect(page).to have_content user.first_name
      expect(page).to have_content user.email
    end
    it '自分のユーザ編集画面へのリンク(Edit your profile)が存在する' do
      expect(page).to have_link '', href: edit_user_path(user)
    end
  end


  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前(first_name)が表示される' do
        expect(page).to have_field 'user[first_name]', with: user.first_name
      end
      it '名前編集フォームに自分の名前(last_name)が表示される' do
        expect(page).to have_field 'user[last_name]', with: user.last_name
      end
      it 'メールアドレス編集フォームにメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '住所編集フォームが表示される' do
        expect(page).to have_field 'user[address]'
      end
      it 'City編集フォームが表示される' do
        expect(page).to have_field 'user[city]'
      end
      it 'Zip/PostalCode編集フォームが表示される' do
        expect(page).to have_field 'user[postal_code]'
      end
      it 'Country編集フォームが表示される' do
        expect(page).to have_field 'user[country]'
      end
      it 'Saveボタンが表示される' do
        expect(page).to have_button 'Save'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_last_name = user.last_name
        @user_old_first_name = user.first_name
        @user_old_email = user.email
        @user_old_address = user.address
        @user_old_city = user.city
        @user_old_postal_code = user.postal_code
        @user_old_country = user.country
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 19)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[address]', with: Faker::Lorem.characters(number: 20)
        fill_in 'user[city]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[postal_code]', with: Faker::Lorem.characters(number: 7)
        click_button 'Save'
      end

      it 'last_nameが正しく更新される' do
        expect(user.reload.last_name).not_to eq @user_old_last_name
      end
      it 'first_nameが正しく更新される' do
        expect(user.reload.first_name).not_to eq @user_old_first_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
      it 'addressが正しく表示される' do
        expect(user.reload.address).not_to eq @user_old_address
      end
      it 'cityが正しく表示される' do
        expect(user.reload.city).not_to eq @user_old_city
      end
      it 'Zip/postal_codeが正しく表示される' do
        expect(user.reload.postal_code).not_to eq @user_old_postal_code
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end  



