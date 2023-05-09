require 'spec_helper'

RSpec.describe Datumine::Node do
  describe '#initialize' do
    it 'creates a new node with the given value' do
      node = Datumine::Node.new(42)
      expect(node.value).to eq(42)
    end

    it 'initializes the parents and children attributes as empty arrays' do
      node = Datumine::Node.new(42)
      expect(node.parents).to eq([])
      expect(node.children).to eq([])
    end
  end

  describe '#add_parent' do
    it 'adds the given node as a parent of the current node' do
      node1 = Datumine::Node.new(42)
      node2 = Datumine::Node.new(43)
      node1.add_parent(node2)
      expect(node1.parents).to eq([node2])
    end
  end

  describe '#add_child' do
    it 'adds the given node as a child of the current node' do
      node1 = Datumine::Node.new(42)
      node2 = Datumine::Node.new(43)
      node1.add_child(node2)
      expect(node1.children).to eq([node2])
    end
  end
end
