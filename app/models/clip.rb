class Clip < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :share_id
  end

  belongs_to :user
  belongs_to :share

end