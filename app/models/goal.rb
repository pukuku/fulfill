class Goal < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :content
  end

  validates :status,inclusion: { in: [true,false]}


  has_many :tasks, dependent: :destroy
  has_many :task_works, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :user
  has_one :share, dependent: :destroy


end