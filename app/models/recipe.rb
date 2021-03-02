class Recipe < ActiveRecord::Base
    belongs_to :author, class_name: "User"
    belongs_to :saver, class_name: "User"
end