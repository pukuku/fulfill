# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Taskモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { task.valid? }

    let!(:user) { create(:user) }
    let!(:goal) { create(:goal, user: user) }
    let!(:task) { build(:task, goal: goal) }

    context 'contentカラム' do
      it '空欄でないこと' do
        task.content = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Goalモデルとの関係' do
      it 'N:1となっている' do
        expect(Task.reflect_on_association(:goal).macro).to eq :belongs_to
      end
    end
    context 'TaskWorkモデルとの関係' do
      it '1:1となっている' do
        expect(Task.reflect_on_association(:task_work).macro).to eq :has_one
      end
    end
  end
end
