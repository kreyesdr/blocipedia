class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wiki
  has_many :collaborators
  has_many :collaborators_wikis, through: :collaborators, source: :wiki

  scope :all_except, -> (user) { where.not(id: user) }
  scope :exclude_collaborators, -> (wiki){where.not(id: wiki.users) }

  before_save { self.role ||= :standard }
  before_save { self.subscribed ||= 0 }

  enum role: [:standard, :premium, :admin]

  def collaborators
    Collaborator.where(wiki_id: id)
  end

end
