class User < ApplicationRecord
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
            :length => { :maximum => 50 },
            :uniqueness => { :case_sensitive => false }

  BANNED_USERNAMES = ["admin", "administrator", "contact", "fraud", "guest",
     "help", "hostmaster", "committi", "mailer-daemon", "moderator",
     "moderators", "nobody", "postmaster", "root", "security", "support",
     "sysop", "webmaster", "enable", "new", "signup",].freeze

  validates_each :username do |record, attr, value|
    if BANNED_USERNAMES.include?(value.to_s.downcase)
      record.errors.add(attr, "is not permitted")
    end
  end
end
