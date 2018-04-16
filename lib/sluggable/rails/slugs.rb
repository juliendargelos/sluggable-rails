class Sluggable::Rails::Slugs
  def initialize
    @slugs = []
  end

  def add(definition, record)
    @slugs << Sluggable::Rails::Slug.new(definition, record)
  end

  def each &block
    @slugs.each &block
  end
end
