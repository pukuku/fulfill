# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TaskWorkモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Goalモデルとの関係' do
      it 'N:1となっている' do
        expect(TaskWork.reflect_on_association(:goal).macro).to eq :belongs_to
      end
    end
    context 'Taskモデルとの関係' do
      it 'N:1となっている' do
        expect(TaskWork.reflect_on_association(:task).macro).to eq :belongs_to
      end
    end
  end
end
