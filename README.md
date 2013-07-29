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
### Configuration file and access tokens

fuci-travis looks for a file called ".fuci-travis.rb" in your project's
root directory. It's recommended that you configure fuci-travis there.
The configuration must include your Travis access token. **Therefore,
you should include .fuci-travis.rb into .gitignore.**

fuci-travis ships with the Travis gem. It includes the Travis CLI and
Ruby wrapper. You'll use the Travis CLI to get your access token.

#### Travis for public repositories

On the command line, log into Travis via Github OAuth:

```sh
travis login
```

Then get your token:

```sh
travis token
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
travis login --pro
```

Then get your token:

```sh
travis token --pro
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

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
