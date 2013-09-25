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

    def []
      @env
    end

    def method_missing(m, *attrs, &block)
      a = m.to_s

      v = @env.fetch(a) do
        ::Kernel.raise "Attribute #{a} not found at /#@root"
      end

      if v.is_a?(::Hash)
        path = a
        path = "#@root." + path if @root

        Tree.new(v, path)
      else
        v
      end
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

end
