ActiveRecord::Base.instance_eval do
  before_save :update_slugs

  def has_slug(attribute = :slug, by:, separator: '-', scope: nil)
    slug_definitions.add attribute, origin: by, separator: separator, scope: scope
    validates attribute, presence: true, uniqueness: scope.present? ? { scope: scope } : true
  end

  def slug_definitions
    @slug_definitions ||= Sluggable::Rails::Definitions.new
  end
end

ActiveRecord::Base.class_eval do
  def slugs
    self.class.slug_definitions.slugs from: self
  end

  protected

  def update_slugs
    slugs.each { |slug| slug.update if slug.needs_an_update? }
  end
end
