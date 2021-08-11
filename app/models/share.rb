class Share < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :goal_id
    validates :category_id
    validates :content
    validates :copy_count
  end

  has_many :clips, dependent: :destroy
  belongs_to :user
  belongs_to :goal
  belongs_to :category

end