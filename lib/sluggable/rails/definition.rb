class Sluggable::Rails::Definition
  attr_reader :attribute, :origin, :separator

  def initialize(attribute = :slug, origin:, separator: '-')
    self.attribute = attribute
    self.origin = origin
    self.separator = separator
  end

  def attribute=(v)
    @attribute = v.to_s.to_sym
  end

  def origin=(v)
    @origin = v.to_s.to_sym
  end

  def separator=(v)
    @separator = v.to_s
  end
end
