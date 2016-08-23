class WikiPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def create?
    user.present?
  end

  def owner
    wiki.user_id == user.id
  end

  def update?
    user.admin? or owner or wiki.private? == false or user.present?
  end
end