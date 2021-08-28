# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { category.valid? }

    let!(:category) { build(:category) }

    context 'nameカラム' do
      it '空欄でないこと' do
        category.name = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Sharesモデルとの関係' do
      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:shares).macro).to eq :has_many
      end
    end
  end
end
