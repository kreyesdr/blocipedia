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
    wiki.user == user
  end

  def update?
    (user.present? && !wiki.private?) || (owner? && wiki.private?) || admin?
  end
end