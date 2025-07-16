class Client < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :destroy
  belongs_to :assigned_to, class_name: "User", optional: true
  belongs_to :data_entry_operator, class_name: "User", optional: true

end