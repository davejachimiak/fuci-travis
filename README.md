# Fuci::Travis
[![Build Status](https://travis-ci.org/davejachimiak/fuci-travis.png?branch=master)](https://travis-ci.org/davejachimiak/fuci-travis)

Run Travis failures locally. A [Fuci](https://github.com/davejachimiak/fuci) server extension.

## Installation

Add this line to your application's Gemfile:

    gem 'fuci-travis', '~> 0.3'

And then execute:

    $ bundle

Bundling the binstub is highly recommended:

    $ bundle binstubs fuci-travis

## Configuration
### Configuration file

To configure itself, fuci-travis looks for a file called
".fuci-travis.rb" in your project's root directory. You should create
that file and configure fuci-travis there. The configuration must
include your Travis access token. **Therefore, you should include
./.fuci-travis.rb in .gitignore.**

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

Fuci tester plugins should return two things: Whether a failed build has
failed with a specific testing framework (e.g. RSpec, Cucumber) and the
command-line command that runs those specific failures. As of now, Fuci
ships with only an RSpec tester plugin. If you want to add custom
testers, add them in the configuration:
```ruby
Fuci::Travis.configure do |fu|
  fu.add_testers Fuci::Spec, Fuci::Jasmine
  fu.access_token = '<access token>'
end
```

See the base Fuci repo for more information on custom testers.

## Usage

See the
[base Fuci repo](https://github.com/davejachimiak/fuci#native-command-line-options)
for command-line options native to Fuci.

Run your latest ci failures locally:
```sh
$ fuci
```
`fuci` will fetch the CI failures from the default branch declared in
your configuration. If no default branch is declared , `fuci` will fetch
the CI failures from the branch of the same name as your current local
branch.

Call `fuci` with a branch name to run a specific branch's failures
branch. For example, this will run the failures from the latest master
build on your local code:
```sh
$ fuci master
```

### Pull request builds
```sh
$ fuci --pull-request
$ # or
$ fuci -p
```

Those will find the latest build triggered by a pull request from the
remote branch of the same name as your current local branch. Use a
branch name as an argument to run failures specific branch's pull
request:

```sh
$ git checkout another_branch
$ fuci -p my_feature_branch_that_breaks_things
```

## Known incompatibilities/weirdnesses
* Build configurations with more than one job. Multiple jobs typically
mean test runs in different environments. Switching between these
environments locally and automatically can be tricky and may not even
be desirable.

## TODO
* Rake task that bootstraps project with gitignore'd config file,
complete with access_token and pro flag
* Support for multiple jobs per build (?)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
