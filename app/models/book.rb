class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # いいね多い順
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  # 閲覧数
  has_many :read_counts, dependent: :destroy


  # 検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
