# Range validator

Validate fields of type `Range`

## Install

gem 'range_validator'

## Example usage

Here using Mongoid's built in Range field support ;)

```ruby
class Search
  include Mongoid::Document

  field :cost, type: Range

  validates :cost, range:  {within: 0..40000 }
end
```

`Search.new cost: (0..2000)`

And here using `factory_girl` gem:

```ruby
FactoryGirl.define do
  sequence(:cost_range)         { [ (0..2000), (2000..4000), (4000..8000) ].sample }

  factory :search do
    cost         { FactoryGirl.generate(:cost_range) }
  end
end
```

Create a Search instance via factory (requires Factory Girl macros enabled):

`create :search`

## Contributing to range_validator
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.

