class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wiki

  before_save { self.role ||= :standard }
  before_save { self.subscribed ||= 0 }

  enum role: [:standard, :premium, :admin]

end
