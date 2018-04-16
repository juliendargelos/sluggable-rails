class Sluggable::Rails::Definitions
  def initialize
    @definitions = {}
  end

  def [](attribute)
    @definitions[attribute.to_s.to_sym]
  end

  def add(attribute = :slug, origin:, separator: '-', scope: nil)
    @definitions[attribute.to_s.to_sym] = Sluggable::Rails::Definition.new attribute, origin: origin, separator: separator, scope: scope
  end

  def slugs(from:)
    slugs = Sluggable::Rails::Slugs.new
    @definitions.each { |_, definition| slugs.add definition, from }
    slugs
  end
end
