# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Goalモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:goals).macro).to eq :has_many
      end
    end
    context 'Shareモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:shares).macro).to eq :has_many
      end
    end
    context 'Clipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:clips).macro).to eq :has_many
      end
    end
  end
end
