class User < ApplicationRecord
  # Relationships
  has_many :challenges, :dependent => :destroy
  has_many :statuses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :enrollments, :dependent => :destroy

  # Validation rules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :validatable, authentication_keys: [:login]
  attr_writer :login

  validates :email,
            :length => { :maximum => 100 },
            # Real email address format
            :format => { :with => /\A[^@ ]+@[^@ ]+\.[^@ ]+\Z/ },
            :uniqueness => { :case_sensitive => false }

  validates :password,
            :presence => true,
            :password_strength => true,
            :on => :create

  validates :username,
            :presence => true,
            :length => { :maximum => 15, :minimum => 3 },
            # Alphanumeric username, dashes allowed but not at the start
            :format => { :with => /\A[a-z0-9][a-z0-9_-]{0,24}\z/ },
            :uniqueness => { :case_sensitive => false }

  validates :bio,
            :length => { :maximum => 300 }

  # For security & trust reasons
  BANNED_USERNAMES = ["admin", "administrator", "contact", "fraud", "guest",
     "help", "hostmaster", "committi", "mailer-daemon", "moderator",
     "moderators", "nobody", "postmaster", "root", "security", "support",
     "sysop", "webmaster", "enable", "new", "signup",].freeze

  validates_each :username do |record, attr, value|
    if BANNED_USERNAMES.include?(value.to_s.downcase)
      record.errors.add(attr, "is not permitted")
    end
  end

  # Helpers
  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase },]).first
  end

  def avatar_url(user, opts = {})
    size = opts[:size || 32]
    hash = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{hash}.png?s=#{size}&d=identicon&r=PG"
  end

  delegate :count, to: :statuses, prefix: true

  delegate :count, to: :comments, prefix: true

  def likes_counter(user)
    Like.where(status: Status.where(user: user)).count
  end

  def matching?(current_user, user)
    current_user == user
  end
end
