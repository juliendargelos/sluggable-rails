module Sluggable::Rails::Concern
  extend ActiveSupport::Concern

  included do
    before_validation :update_slugs
  end

  def slugs
    self.class.slug_definitions.slugs from: self
  end

  module ClassMethods
    def has_slug(attribute = :slug, by:, separator: '-', scope: nil)
      slug_definitions.add attribute, origin: by, separator: separator, scope: scope
      validates attribute, presence: true, uniqueness: scope.present? ? { scope: scope } : true
    end

    def slug_definitions
      @slug_definitions ||= Sluggable::Rails::Definitions.new
    end
  end

  protected

  def update_slugs
    slugs.each { |slug| slug.update if slug.needs_an_update? }
  end
end
