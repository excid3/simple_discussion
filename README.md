# SimpleDiscussion

SimpleDiscussion is a Rails forum gem extracting the forum from
[GoRails' forum](https://gorails.com/forum). It includes categories,
simple moderation, the ability to mark threads as solved, and more.

## Installation

Before you get started, SimpleDiscussion requires a `User` model in your application (for now). 

Add this line to your application's Gemfile:

```ruby
gem 'simple_discussion'
```

And then execute:

```bash
bundle
```

Install the migrations and migrate:

```bash
rails simple_discussion:install:migrations
rails db:migrate
```

Add SimpleDiscussion to your `User` model. The model **must** have `name` method which will be used to display the user's name on the forum. Currently only a model named `User` will work, but this will be fixed shortly.

```ruby
class User < ActiveRecord::Base
  include SimpleDiscussion::ForumUser

  def name
    "#{first_name} #{last_name}"
  end
end
```

Optionally, you can add a `moderator` flag to the `User` model to allow users to edit threads and posts they didn't write.

```bash
rails g migration AddModeratorToUsers moderator:boolean
rails db:migrate
```

Add the following line to your `config/routes.rb` file:

```ruby
mount SimpleDiscussion::Engine => "/forum"
```

You can also add the CSS to your `application.css` to load some helpful default styles.

```javascript
//= require simple_discussion
```

## Usage

To get all the basic functionality, the only thing you need to do is add a link to SimpleDiscussion in your navbar.

```erb
<%= link_to "Forum", simple_discussion_path %>
```

This will take the user to the views inside the Rails engine.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/excid3/simple_discussion. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleDiscussion project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple_discussion/blob/master/CODE_OF_CONDUCT.md).
