# Sluggable Rails 🏅
Provide a unique slug to your records, generated from the attribute of your choice.

## Usage
Use the `has_slug` method:

```ruby
# == Schema Information
#
# Table name: Post
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  has_slug by: :title
end
```

In this example, the slug will be generated from the post title. By default, it will be stored in the slug attribute.
You can choose another attribute to store it:

```ruby
has_slug :custom_attribute, by: :title
```

The slug is generated with the [`parameterize` method](http://api.rubyonrails.org/v5.1/classes/ActiveSupport/Inflector.html#method-i-parameterize), you can specify a separator as it excepts (default: `'-'`):

```ruby
has_slug :custom_attribute, by: :title, separator: '_'
```

Obviously, you have to add the corresponding column to your schema:

```ruby
class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug, null: false, index: true, unique: true # Or your custom attribute

      t.timestamps
    end
  end
end
```

The slug will be automatically generated in order to be unique. And a `presence` and `uniqueness` validations will also be added by the `has_slug` method.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sluggable-rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install sluggable-rails
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
