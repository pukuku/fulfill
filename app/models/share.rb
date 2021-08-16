class Share < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :goal_id
    validates :category_id
    validates :content
  end

  has_many :clips, dependent: :destroy
  belongs_to :user
  belongs_to :goal
  belongs_to :category

  def cliped_by?(user)
	  clips.where(user_id: user.id).exists?
  end


# Goal.joins(:share).where("share.id IS NOT NULL")

# def self.search(category,status,sort,word)
#   if category == nil
#     if status == "0"
#       if sort == "0"
#         Goal.share_join.share_word(word)
#       else
#         Goal.share_join.share_word(word).sort
#       end
#     else
#       if sort == "0"
#         Goal.share_join.share_status.share_word(word)
#       else
#         Goal.share_join.share_status.share_word(word).share_sort
#       end
#     end
#   else
#     if status == "0"
#       if sort == "0"
#         Goal.share_join.share_word(word).share_category(category)
#       else
#         Goal.share_join.share_word(word).share_category(category).share_sort
#       end
#     else
#       if sort == "0"
#         Goal.share_join.share_status.share_category(category).share_word(word)
#       else
#         Goal.share_join.share_status.share_word(word).share_category(category).share_sort
#       end
#     end
#   end
# end

def self.search(category,status,sort,word)


end

end