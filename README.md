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

## Badges

[![Build Status](https://travis-ci.org/snmgian/yew.svg?branch=master)](https://travis-ci.org/snmgian/yew) [![Code Climate](https://codeclimate.com/github/snmgian/yew.png)](https://codeclimate.com/github/snmgian/yew)

## License

This software is licensed under the [LGPL][lgpl] license.

[lgpl]: https://www.gnu.org/licenses/lgpl.html

## Art

``` markdown

                                  .:   ,~ :
                                  +7Z?~+$Z$.    .
                                 ~$ZZZZ7$OZ$.,::~:~.
                             .::IZ$$O8Z$ZZZ$$$7OOO7.
                            7$$$$Z$$OZZOZZZOOZOOZ$$$:.+,~
                       .. . $Z$ZZZ$$$OZZOZ$O88$OOO8OO8ZZ~
                        :,?$ZOOZZ88$OOZ$OOOO8OZOOOOO88OZ~+~,
                       .=ZZOOOOZOO8OOZOZOO8Z8OZO8OOOOO888ZZ::.
                       ~7ZOZOOZOO8O8O8O8D8OOZOOZDDD8ZO8O888O?I
                   . +..$OZOOO8O88D8Z88OOD8ZOOO8OZOO8$O88OOZ$O:~. .
              .   .?.?+7ZZOOO8888D888DDO88888O8ZO88Z88Z888888OZ~.:.
              ?~7$ZZZOZOZOOO88D888ZDD888D8888888OOOOODZ8OO8OZ88OZ7$+
              IZOO$OZO8ZZOOD$ZO8DZ8D88888ZD8D8OD88OO8OZOO$OOOOOO8O+:
             .,.$OZOZOZZZZ88O88O88OO888ON88DO888ZD8O88~7ZOO$$Z88OOO+
            ~ZZ?ZZZZOZO8O8ZOZOZO888888888O8O8888D88D8~8888O88O8ZO8$.=
            ?ZZZ8OZOO8O8OOO8OOO8888888DD8O8O88ODO8D88DD88DZ8888O88$ZI ..
        .. ?$?O8OOO8OZ8D8OZ8ZOODOOO8888D8ODZDDD8ONDO888OO8O88D8OOZOZZ7.~..
        ,+.7ZO8O8888O88O888888OO7?DD888888D88O8888OOOD88OZD8Z88888OOOZ+: ,
      ?.I$ZOO8OO8OZ88D8OO8OOO8DDZ7?88NO88O88DD888DO88888DO8888888888O8ZZO~
      .I=8OOO$8$7.I$888888888D88DDDO8DO8DD8D8D8DD8DD8D88OODZD8DO88O8888O.
     .$7O888888888O8888D8DOO878D88$O78888D8888?ZOO87O8888D8DD888$O8OO8OI=.
    =~O8OO87O88OIDDZ7Z=?D88DZN8D8OO8O88DD88DO88O8D8ODDZDD888DO+OZ8O8O88$=:.
    .:OZO7OO88$D8Z+8~8ZD$88DDNO8$8ODO,OD8DODNOZO8D8DOOO88D8OO8888888Z8ZZO.
     :Z7888DD88D8DODD$D~~,Z?OONDNI?ZDDDNDD8D8D+7Z~:DD8I8888888888DO88OOO$.
     .~8O8D8O88D8ZO8Z$8Z:OZO$=88DDDDDDDDOOD8DDDDDNN~~,~DD88O88DD88OZ$O+,.
       .=DDNNDD88O+ZDDI88OO,,88DDDDDNDDDNN?7Z:ZDNNDN7+$+Z?8888OZO$$,.~ .
          .DND+7+,,I~~=7$:Z=IO=?Z$DONDDD88OZ.:?ZNNNNDDDD8888Z7=7+I+ ,
            .+=,    .:=~:.II....Z8DD88DOOO:.,=+::+~8OD88OZ~=ZZ+.
                          .I,/ZO?7O8OZD$$Z:$:       +I7+$\\7+8ZI.
                           //~,.==7Z?$Z$=$             ~,$ \\~.
                         /:    ~=.7Z?OO?$$,
 .-+--$-?--?--..++::=~,          +7I7ZO7I7$,
,,. .,:,,=~+..??.:I?,.?+-,,-.,,../7I7ZO7I7$.,,,,..,,,..=.+~..7:7,.7.,-~.+,
                              ../7Z+=ZZ077Z$~,,..,.,,.  ,:,???+?+.:+.,.+.=I=.=:.
                                   ....   .    ..  .

