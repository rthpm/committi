class User < ApplicationRecord
  # Relationships
  has_many :challenges, :dependent => :destroy

  # Validation rules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
            :length => { :maximum => 50, :minimum => 3 },
            # Alphanumeric username, dashes allowed but not at the start
            :format => { :with => /\A[a-z0-9][a-z0-9_-]{0,24}\z/ },
            :uniqueness => { :case_sensitive => false }

  validates :screen_name,
            :length => { :maximum => 25 }

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
  def self.greet_who(user)
    user.screen_name || user.username
  end
end
