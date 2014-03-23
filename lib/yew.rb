require 'yaml'

module Yew
  def self.load(*yml_files)
    env_hash = yml_files.inject({}) do |memo, yml|
      memo.merge! YAML.load(File.read(yml))
    end

    Tree.new(env_hash)
  end

  class Tree < BasicObject
    def initialize(env, root = nil)
      @env = env
      @root = root
    end

    def [](*key)
      if key.any?
        key = key.first
        Utils.fetch(key, @env, @root)

      else
        @env
      end
    end

    def method_missing(m, *attrs, &block)
      Utils.fetch(m, @env, @root)
    end

    if $YEW_DEBUG
      def inspect
        "<Envy::Env:#{__id__} -> #@env>"
      end

      def to_s
        "Env -> #@env"
      end
    end
  end

  module Utils
    def self.fetch(key, env, root)
      value = raw_fetch(key, env, root)

      if value.is_a?(Hash)
        path = key
        path = "#{root}.#{path}" if root

        Tree.new(value, path)
      else
        value
      end
    end

    def self.raw_fetch(key, env, root)
      env.fetch(key) do
        env.fetch(key.to_s) do
          raise "Attribute #{key} not found at /#{root}"
        end
      end
    end
  end
end
