class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # いいね多い順
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  # 閲覧数
  has_many :read_counts, dependent: :destroy
  # 動画投稿用
  has_one_attached :video


  # 検索機能
  def self.search_for(search, word)
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

  # scope :sorted_by_favorite_count,lambda{
  #   to = Time.current.at_end_of_day
  #   from = (to - 6.days).at_beginning_of_day
  #   joins("LEFT JOIN favorites ON books.id = favorites.book_id AND favorites.created_at >= '#{from}' AND favorites.created_at <= '#{to}'")
  #   .group('books.id')
  #   .select('books.*, COUNT(favorites.id) as favorites_count')
  #   .order('favorites_count DESC')
  # }
  # scope :latest, -> {order(created_at: :desc)}
  # scope :old, -> {order(created_at: :asc)}
  # scope :star_count, -> {order(star: :desc)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private
  def clip_type
    if clip.attached? && !clip.content_type.in?(%w(video/mp4 video/mov video/avi video/quicktime).map(&:downcase))
    end
  end
end