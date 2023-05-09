module Datumine
  class DAG
    class NodeNotFoundError < StandardError; end

    attr_reader :nodes

    def initialize
      @nodes = {}
    end

    def add_node(value)
      node = Node.new(value)
      nodes[node.object_id] = node
      node
    end

    def connect_nodes(parent, child)
      raise NodeNotFoundError, "parent node not found" unless nodes.include?(parent.object_id)
      raise NodeNotFoundError, "child node not found" unless nodes.include?(child.object_id)

      parent.children << child
      child.parents << parent
    end

    def remove_node(node)
      node.children.each { |child| child.parents.delete(node) }
      node.parents.each { |parent| parent.children.delete(node) }
      nodes.delete(node.object_id)
      node
    end

    def traverse(&block)
      visited = {}
      nodes.each_value do |node|
        puts node.value
        traverse_node(node, visited, &block) unless visited[node]
      end
    end

    private

    def traverse_node(node, visited, &block)
      visited[node] = true
      node.parents.each do |parent|
        traverse_node(parent, visited, &block) unless visited[parent]
      end
      yield node
    end
  end
end
