class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: { without: /\b[A-Z0-9._%a-z\-]+@(gmail|hotmail|yahoo|paynow)/ }

  belongs_to :company, optional: true

  enum role: { company_employee: 0, company_admin: 10  }
end
