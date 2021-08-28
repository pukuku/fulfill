# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reportモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { report.valid? }

    let!(:user) { create(:user) }
    let!(:goal) { create(:goal, user_id: user.id) }
    let!(:report) { build(:report, goal_id: goal.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        report.comment = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Goalモデルとの関係' do
      it 'N:1となっている' do
        expect(Report.reflect_on_association(:goal).macro).to eq :belongs_to
      end
    end
  end
end
