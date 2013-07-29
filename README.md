# Fuci::Travis

Run Travis failures locally.

## Installation

Add this line to your application's Gemfile:

    gem 'fuci-travis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuci-travis

## Configuration
### Configuration file

fuci-travis looks for a file called ".fuci-travis.rb" in your project's
root directory. It's recommended that you configure fuci-travis there.
The configuration must include your Travis access token. **Therefore,
you should include .fuci-travis.rb into .gitignore.**

".fuci-travis.rb" should include a call to `Fuci::Travis.configure` with
a block that sets your access token and other options.

### Access tokens

fuci-travis ships with the Travis gem. It includes the Travis CLI and
Ruby wrapper. You'll use the Travis CLI to get your access token.

#### Travis for public repositories

On the command line, log into Travis via Github OAuth:
```sh
$ travis login
```

Then get your token:
```sh
$ travis token
# Your access token is <access token>
```

Then, in .fuci-travis.rb, configure fuci-travis with your access token
as a string:
```ruby
Fuci::Travis.configure do |fu|
  fu.access_token = '<access token>'
end
```

#### Travis for private repositories

This is similar to the process for public repositories, but uses the
`--pro` flag.

On the command line, log into Travis via Github OAuth:
```sh
$ travis login --pro
```

Then get your token:
```sh
$ travis token --pro
# Your access token is <access token>
```

Then, in .fuci-travis.rb, **set `pro` to true** and configure
fuci-travis with your access token as a string:
```ruby
Fuci::Travis.configure do |fu|
  fu.pro          = true
  fu.access_token = '<access token>'
end
```

### Default branch

If you push to a dedicated ci branch to check your changes before
merging into master, set that branch as the default branch in the
configuration:
```ruby
Fuci::Travis.configure do |fu|
  fu.default_branch = 'my-ci'
  fu.access_token   = '<access token>'
end
```

### Adding custom tester plugins

Fuci ships with some tester plugins. If you want to add custom testers,
add them in the configuration:
```ruby
Fuci::Travis.configure do |fu|
  fu.add_testers Fuci::Spec, Fuci::Jasmine
  fu.access_token = '<access token>'
end
```

See the base Fuci repo for more information on custom testers.

## Usage

To run your latest ci failures locally:
```sh
$ fuci
```
`fuci` will attempt to fetch the default branch declared in the
configuration. If no default branch is declared, it will attempt to
fetch your current local branch.

To run another remote branch's failures against your current local
branch, call `fuci` with the branch:
```sh
$ fuci master
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
