class Document < ApplicationRecord
  belongs_to :client

  has_one_attached :file

  validates :title, presence: true
end