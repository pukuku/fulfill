class Help < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :body
  end

  # 追加メソッド
  def self.search(search_word)
    where(["title like?", "%#{search_word}%"])
  end
end
