class User < ApplicationRecord
  has_secure_password

  before_save :format_username

  scope :by_name, -> { order(:name) }

  scope :not_admins, -> { by_name.where(admin: false) }

  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true

  validates :email, presence: true,
  format: { with: /\S+@\S+/ },
  uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 10, allow_blank: true }

  validates :username, format: { with: /\A[A-Z0-9]+\z/i },
                     uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def format_username
    self.username = username.downcase
  end
  
end
