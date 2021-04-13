require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let(:user) { User.new(params) }
    let(:params) { { last_name: 'Daidai',first_name: 'Maru' } }
    let(:other_user){ User.new(last_name: "Korikori", first_name:"Maru") }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.last_name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.last_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること: 21文字は×' do
        user.last_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '空欄でないこと' do
        user.first_name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.first_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること: 21文字は×' do
        user.first_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'orderモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:orders).macro).to eq :has_many
      end
    end
    context 'cart_itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:cart_items).macro).to eq :has_many
      end
    end
    context 'dliveryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:deliveries).macro).to eq :has_many
      end
    end
    context 'reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
