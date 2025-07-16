class User < ApplicationRecord
  has_one :client, dependent: :destroy
  has_many :assigned_clients, class_name: "Client", foreign_key: :data_entry_operator_id


  enum :role, {
    super_admin: 0,
    manager: 1,
    supervisor: 2,
    data_entry_operator: 3,
    client: 4
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
  