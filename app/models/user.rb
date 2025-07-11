class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: {
      super_admin: 0,
      manager: 1,
      supervisor: 2,
      data_entry_operator: 3,
      client: 4
    }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
