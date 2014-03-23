# Yew

Yew allows traversing a Hash structure as if it is an object tree.


## Usage

Given the following yml file located at `config/env.yml`:

  ``` yaml
  orientdb:
    url: 'remote:localhost/db'
    user: admin
    pass: secret

  testing:
    frameworks:
      minitest: true
      rspec: false
  ```


 - Load the YAML structure.

    ``` ruby
    Env = Yew.load('config/env.yml')
    ```


 - Traverse the structure contents.

    ``` ruby
    Env.orientdb.user
    # => 'admin'
    ```

 - Obtain the underlying Hash.

    ``` ruby
    Env.testing.frameworks[]
    # => {"rspec"=>false, "minitest"=>true}
    ```


 - A tree can also be traversed like a normal Hash.

    ``` ruby
    Env['orientdb']['user']
    # => 'admin'

    Env['orientdb'].user
    # => 'admin'
    ```


 - It raises well formed errors when accessing inexistent paths.

    ``` ruby
    Env['orientdb'].timeout
    # => RuntimeError: Attribute timeout not found at /orientdb
    ```


 - Set `$YEW_DEBUG` when need to inspect `Yew::Tree` objects under irb.


    ``` ruby
    irb> $YEW_DEBUG = true
    irb> require 'yew'
    ```

## Installation

There are two options for installation: packaged gem and source file.

 1. Install Yew as a gem.

    ``` shell
    gem install yew
    ```


 2. Download raw lib into a project source tree.

    ``` shell
    curl "https://raw.github.com/snmgian/yew/master/lib/yew.rb" 2>/dev/null -o "yew.rb"
    ```

## Running tests

Tests are written in MiniTest. To run them all just execute the following from your command line:

  ``` shell
  ruby -I. test/ts_yew.rb
  ```

## License

This software is licensed under the [LGPL][lgpl] license.

[lgpl]: https://www.gnu.org/licenses/lgpl.html

## Badges

[![Build Status](https://travis-ci.org/snmgian/yew.svg?branch=master)](https://travis-ci.org/snmgian/yew) [![Code Climate](https://codeclimate.com/github/snmgian/yew.png)](https://codeclimate.com/github/snmgian/yew)
