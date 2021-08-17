class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
  end

  has_many :goals, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :clips, dependent: :destroy

  attachment :user_image

end