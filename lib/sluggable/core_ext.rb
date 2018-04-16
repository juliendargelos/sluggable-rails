ActiveRecord::Base.class_eval do
  include Sluggable::Rails::Concern
end
