class Sluggable::Rails::Slug < String
  attr_accessor :definition, :record
  attr_reader :offset

  def initialize(definition, record)
    self.definition = definition
    self.record = record
  end

  def update
    if make
      record.send "#{definition.attribute}=", self.to_s
      true
    else
      false
    end
  end

  def make
    if makeable?
      @offset = 0
      generate until present? && unique?
      true
    else
      false
    end
  end

  def base
    String.try_convert(record.send(definition.origin)).to_s.parameterize separator: definition.separator
  end

  def makeable?
    definition.is_a?(Sluggable::Rails::Definition) && record.is_a?(ActiveRecord::Base)
  end

  def shifted?
    !offset.zero?
  end

  def changed?
    record.send "#{definition.origin}_changed?"
  end

  def undefined?
    record.send(definition.attribute).blank?
  end

  def needs_an_update?
    undefined? || changed?
  end

  def scope
    definition.scope.map{ |attribute| [attribute, record.send(attribute)] }.to_h
  end

  protected

  def generate
    clear
    insert 0, base
    insert -1, (empty? ? '' : definition.separator) + offset.to_s if shifted?
    shift
  end

  def shift
    @offset += 1
  end

  def unique?
    found = record.class.find_by({ definition.attribute => self.to_s }.merge(scope))
    !found || found.id == record.id
  end
end
