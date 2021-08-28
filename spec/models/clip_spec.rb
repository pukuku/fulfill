# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Goalモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Clip.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Shareモデルとの関係' do
      it 'N:1となっている' do
        expect(Clip.reflect_on_association(:share).macro).to eq :belongs_to
      end
    end
  end
end
