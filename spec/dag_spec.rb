require 'spec_helper'

RSpec.describe Datumine::DAG do
  let(:dag) { Datumine::DAG.new }

  describe "#initialize" do
    it "creates a new DAG object with an empty collection of nodes" do
      expect(dag.nodes).to be_empty
    end
  end

  describe "#add_node" do
    it "adds a new node to the nodes hash and returns it" do
      node = dag.add_node("value")
      expect(dag.nodes.length).to eq(1)
      expect(node).to be_a(Datumine::Node)
      expect(node.value).to eq("value")
    end
  end

  describe "#connect_nodes" do
    let(:dag) { Datumine::DAG.new }
    let(:parent) { dag.add_node("parent") }
    let(:child) { dag.add_node("child") }
  
    it "connects the parent and child nodes" do
      dag.connect_nodes(parent, child)
      expect(parent.children).to eq([child])
      expect(child.parents).to eq([parent])
    end
  
    it "raises an error if either parent or child nodes are not in the graph" do
      invalid_node = Datumine::Node.new("invalid")
      expect { dag.connect_nodes(parent, invalid_node) }.to raise_error(Datumine::DAG::NodeNotFoundError)
      expect { dag.connect_nodes(invalid_node, child) }.to raise_error(Datumine::DAG::NodeNotFoundError)
      expect { dag.connect_nodes(invalid_node, invalid_node) }.to raise_error(Datumine::DAG::NodeNotFoundError)
    end
  end

  describe "#remove_node" do
    let(:node) { dag.add_node("value") }

    it "removes a node from the nodes hash and returns it" do
      removed_node = dag.remove_node(node)
      expect(dag.nodes.length).to eq(0)
      expect(removed_node).to be_a(Datumine::Node)
      expect(removed_node).to eq(node)
      expect(removed_node.value).to eq("value")
    end

    context "when the node has connections" do
      let(:parent_node) { dag.add_node("parent value") }
      let(:child_node) { dag.add_node("child value") }

      before do
        dag.connect_nodes(parent_node, node)
        dag.connect_nodes(node, child_node)
      end

      it "removes the node from the DAG and disconnects it from the connected nodes" do
        removed_parent = dag.remove_node(parent_node)

        expect(dag.nodes.length).to eq(2)
        expect(removed_parent).to be_a(Datumine::Node)
        expect(removed_parent).to eq(parent_node)
        expect(removed_parent.value).to eq("parent value")
        expect(node.parents.count).to eq(0)

        removed_child = dag.remove_node(child_node)

        expect(dag.nodes.length).to eq(1)
        expect(removed_child).to be_a(Datumine::Node)
        expect(removed_child).to eq(child_node)
        expect(removed_child.value).to eq("child value")
        expect(node.children.count).to eq(0)
      end
    end
  end

  describe "#traverse" do
    let(:n3) { dag.add_node("n3") }
    let(:n1) { dag.add_node("n1") }
    let(:n5) { dag.add_node("n5") }
    let(:n2) { dag.add_node("n2") }
    let(:n4) { dag.add_node("n4") }
    let(:n7) { dag.add_node("n7") }
    let(:n6) { dag.add_node("n6") }

    before do
      dag.connect_nodes(n1, n2)
      dag.connect_nodes(n1, n3)
      dag.connect_nodes(n2, n4)
      dag.connect_nodes(n3, n4)
      dag.connect_nodes(n4, n5)
      dag.connect_nodes(n5, n6)
      dag.connect_nodes(n5, n7)
    end

    it "traverses the graph in topological sort order, yielding each node to the block" do
      result = []
      dag.traverse { |node| result << node.value }
      expect(result).to eq(["n1", "n2", "n3", "n4", "n5", "n6", "n7"])
    end

    context "when there is an isolated node" do
      let!(:isolated_node) { dag.add_node("isolated node") }

      it "traverses the graph in topological sort order, including the isolated node" do
        result = []
        dag.traverse { |node| result << node.value }
        expect(result).to eq(["n1", "n2", "n3", "n4", "n5", "n6", "n7", "isolated node"])
      end
    end
  end
end
