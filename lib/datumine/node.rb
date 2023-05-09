module Datumine
  class Node
    attr_accessor :value, :parents, :children

    def initialize(value)
      @value = value
      @parents = []
      @children = []
    end

    def add_parent(parent)
      @parents << parent
    end

    def add_child(child)
      @children << child
    end

    def isolated?
      parents.none? && children.none?
    end
  end
end
