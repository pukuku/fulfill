# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Goalモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { goal.valid? }

    let!(:user) { create(:user) }
    let!(:goal) { build(:goal, user_id: user.id) }

    context 'contentカラム' do
      it '空欄でないこと' do
        goal.content = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Goal.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Taskモデルとの関係' do
      it '1:Nとなっている' do
        expect(Goal.reflect_on_association(:tasks).macro).to eq :has_many
      end
    end
    context 'TaskWorkモデルとの関係' do
      it '1:Nとなっている' do
        expect(Goal.reflect_on_association(:task_works).macro).to eq :has_many
      end
    end
    context 'Reportモデルとの関係' do
      it '1:Nとなっている' do
        expect(Goal.reflect_on_association(:reports).macro).to eq :has_many
      end
    end
    context 'Shareモデルとの関係' do
      it '1:1となっている' do
        expect(Goal.reflect_on_association(:share).macro).to eq :has_one
      end
    end
  end
end
