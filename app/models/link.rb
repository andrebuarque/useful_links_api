class Link < ApplicationRecord
	belongs_to :category
	has_and_belongs_to_many :tags, :dependent => :delete_all
end
