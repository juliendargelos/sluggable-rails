class Sluggable::Rails::Definition
  attr_reader :attribute, :origin, :separator, :scope

  def initialize(attribute = :slug, origin:, separator: '-', scope: nil)
    self.attribute = attribute
    self.origin = origin
    self.separator = separator
    self.scope = scope
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

  def scope=(v)
    @scope = [v].flatten.map{ |attribute| :"#{attribute}" }.compact.uniq
  end
end
