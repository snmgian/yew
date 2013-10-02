$YEW_DEBUG = true
require 'yew'

Env = Yew.load('config/env.yml')
Env[]
Env.orientdb[]
Env.orientdb.url
Env['orientdb']
Env['orientdb'].url
