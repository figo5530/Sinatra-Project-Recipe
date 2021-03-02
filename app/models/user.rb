class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    validates_uniqueness_of :username
    validates_uniqueness_of :email
    has_many :authored_recipes, foreign_key: "author_id", class_name: "Recipe"
    has_many :saved_recipes, foreign_key: "save_id", class_name: "Recipe"
    def slug
        username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        User.all.find {|u| u.slug == slug }
    end
end