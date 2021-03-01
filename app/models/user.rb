class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    validates_uniqueness_of :username
    validates_uniqueness_of :email
end