# Sluggable Rails 🏅
[![Gem Version](https://badge.fury.io/rb/sluggable-rails.svg)](https://badge.fury.io/rb/sluggable-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/d260555b2cbb561875b4/maintainability)](https://codeclimate.com/github/juliendargelos/sluggable-rails/maintainability)

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

class Post < ApplicationRecord
  #...

  has_slug by: :title

  #...
end
```

```ruby
post = Post.create title: 'My first slugified post!'
post.slug # "my-first-slugified-post"

another_post = Post.create title: 'My first slugified post!'
another_post.slug # "my-first-slugified-post-1"
```

In this example, the slug will be generated from the post title. By default, it will be stored in the slug attribute.
You can choose another attribute to store it:

```ruby
class Post < ApplicationRecord
  #...

  has_slug :custom_attribute, by: :title

  #...
end
```

The slug is generated with the [`parameterize` method](http://api.rubyonrails.org/v5.1/classes/ActiveSupport/Inflector.html#method-i-parameterize), you can specify a separator as it expects (default: `'-'`):

```ruby
class Post < ApplicationRecord
  #...

  has_slug :custom_attribute, by: :title, separator: '_'

  #...
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

Moreover, you can define a scope for your slug so its uniqueness will depends on others attributes:

```ruby
class Post < ApplicationRecord
  #...
  
  belongs_to :user
  has_slug by: :title, scope: :user_id
  # You can specify more than one attribute by giving an array of attributes to the scope option.

  #...
end
```

In this example, each post will have a slug which is unique for the user it belongs to (but it could be any other attribute).

The corresponding migration would be:

```ruby
class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :slug, null: false

      t.timestamps
    end

    add_index :posts, [:user_id, :slug], unique: true
  end
end
```

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
