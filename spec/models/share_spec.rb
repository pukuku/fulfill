# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shareモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { share.valid? }

    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:goal) { create(:goal, user: user) }
    let!(:share) { build(:share, user: user, goal: goal, category: category ) }

    context 'contentカラム' do
      it '空欄でないこと' do
        share.content = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Share.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Goalモデルとの関係' do
      it '1:1となっている' do
        expect(Share.reflect_on_association(:goal).macro).to eq :belongs_to
      end
    end
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Share.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
    context 'Clipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Share.reflect_on_association(:clips).macro).to eq :has_many
      end
    end
  end
end
