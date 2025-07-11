class Client < ApplicationRecord
	belongs_to :assigned_to, class_name: "User", optional: true
	has_many :documents, dependent: :destroy
end
