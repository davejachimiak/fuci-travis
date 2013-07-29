# Fuci::Travis

Run Travis failures locally.

## Installation

Add this line to your application's Gemfile:

    gem 'fuci-travis', '~> 0.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuci-travis

## Configuration
### Configuration file

To configure itself, fuci-travis looks for a file called
".fuci-travis.rb" in your project's root directory. You should create
that file and configure fuci-travis there. The configuration must
include your Travis access token.**Therefore, you should include
./.fuci-travis.rb into .gitignore.**

That configuration file should include a call to
`Fuci::Travis.configure` with a block that sets your access token and
other configurations.

### Access tokens

fuci-travis ships with the
[Travis CI Client](https://github.com/travis-ci/travis) which includes
the Travis CLI. You'll use the Travis CLI to get your access token.

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

Configure fuci-travis with your access token as a string in
.fuci-travis.rb:
```ruby
Fuci::Travis.configure do |fu|
  fu.access_token = '<access token>'
end
```

#### Travis for private repositories

This is the same as above, but uses the Travis CLI `--pro` flag.

On the command line, log into Travis via Github OAuth:
```sh
$ travis login --pro
```

Then get your token:
```sh
$ travis token --pro
# Your access token is <access token>
```

Then, in .fuci-travis.rb, configure fuci-travis with your access token
as a string and **set `pro` to true**:
```ruby
Fuci::Travis.configure do |fu|
  fu.pro          = true
  fu.access_token = '<access token>'
end
```

### Default branch

If you push to a dedicated ci branch to check your changes before
merging them into master, set that branch as the default in the
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

Run your latest ci failures locally:
```sh
$ fuci
```
`fuci` will fetch the default branch declared in your configuration. If
no default branch is declared, `fuci` will fetch your current local branch.

To run a specific branch's failures branch, call `fuci` with the branch.
For example, this will run your failures from the master branch's build
on your local code:
```sh
$ fuci master
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
