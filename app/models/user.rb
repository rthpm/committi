class User < ApplicationRecord
  # Validation rules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email,
            :length => { :maximum => 100 },
            :format => { :with => /\A[^@ ]+@[^@ ]+\.[^@ ]+\Z/ },
            :uniqueness => { :case_sensitive => false }

  validates :password,
            :presence => true,
            :on => :create

  validates :username,
            :presence => true,
            :length => { :maximum => 25, :minimum => 3 },
            # Alphanumeric username, dashes allowed but not at the start
            :format => { :with => /\A[A-Za-z0-9][A-Za-z0-9_-]{0,24}\z/ },
            :uniqueness => { :case_sensitive => false }

  validates :screen_name,
            :length => { :maximum => 25, :minimum => 3 }

  BANNED_USERNAMES = ["admin", "administrator", "contact", "fraud", "guest",
     "help", "hostmaster", "committi", "mailer-daemon", "moderator",
     "moderators", "nobody", "postmaster", "root", "security", "support",
     "sysop", "webmaster", "enable", "new", "signup",].freeze

  validates_each :username do |record, attr, value|
    if BANNED_USERNAMES.include?(value.to_s.downcase)
      record.errors.add(attr, "is not permitted")
    end
  end

  # Relationships
  has_many :challenges, :dependent => :destroy

  # Helpers
  def self.greet_who(user)
    user.screen_name || user.username
  end
end
