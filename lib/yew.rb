require 'yaml'

module Yew

  # Creates an object tree based on a given list of yml files.
  #
  # @param [*String] Yaml source files
  #
  # @return [Yew::Tree]
  def self.load(*yml_files)
    env_hash = yml_files.inject({}) do |memo, yml|
      memo.merge!(YAML.load(File.read(yml)))
    end

    Tree.new(env_hash)
  end

  # The object tree. Allows root-to-leave navigation in the form of ordinary method calls.
  class Tree < BasicObject

    # @param [Hash] env
    # @param root Tree's root. Used for notifying a not found entry at an exact path point.
    def initialize(env, root = nil)
      @env = env
      @root = root
    end

    # Fetches a branch or leaf.
    #
    # If no key is received, returns the underlying Hash.
    #
    # @param key Node's name.
    #
    # @return [Yew::Tree] When the request node is still a tree.
    # @return [Hash] Underlying Hash.
    # @return [Object] When the requested node is a leaf.
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

    def inspect
      if $YEW_DEBUG
        "<Yew::Env:#{__id__} -> #@env>"
      else
        super
      end
    end

    def to_s
      if $YEW_DEBUG
        "Env -> #@env"
      else
        super
      end
    end
  end

  module Utils

    # Fetches the key's value.
    #
    # Returns a tree if the value is a hash. Otherwise it returns the raw value.
    #
    # @return [Yew::Tree]
    # @return [Object]
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

    # Fetches a value from the env.
    #
    # @raise [RuntimeError] When key not found.
    def self.raw_fetch(key, env, root)
      env.fetch(key) do
        env.fetch(key.to_s) do
          raise "Attribute #{key} not found at /#{root}"
        end
      end
    end
  end
end
