class WikiPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def create?
    user.present?
  end

  def admin?
    user.admin?
  end

  def owner?

  end

  def update?
    user.present? or admin? and wiki.private? == false
  end
end