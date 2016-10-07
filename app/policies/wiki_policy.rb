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
    (user.present? && wiki.private?) || (owner? && wiki.private?) || admin?
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role = 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end

    def index
      @wikis = policy_scope(Wiki)
    end
  end
end