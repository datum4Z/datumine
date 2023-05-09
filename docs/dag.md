`DAG` Class

The `DAG` class represents a directed acyclic graph (DAG) used for modeling ETL and data processing scheduling systems. Each `DAG` contains a collection of `Node` objects, which can be added or removed from the graph, and connected to each other to represent dependencies between ETL or processing tasks.

The `DAG` class provides the following attributes:

### `nodes`
* Type: Hash of `Node`s
* Description: The collection of `Node` objects that make up the graph. Each `Node` is stored in the hash with its object ID as the key.

The `DAG` class provides the following methods:

### `initialize`
* Description: Creates a new `DAG` object with an empty collection of `Node` objects.

### `add_node(value)`
* Description: Adds a new `Node` object with the given value to the graph and returns the new `Node`.
* Parameters:
  * `value` (Any): The value of the new `Node`.

### `connect_nodes(parent, child)`
* Description: Connects the given `parent` and `child` `Node` objects in the graph by adding the `child` to the `parent`'s children list and the `parent` to the `child`'s parents list.
* Parameters:
  * `parent` (`Node`): The parent `Node`.
  * `child` (`Node`): The child `Node`.

### `remove_node(node)`
* Description: Removes the given `Node` object from the graph, disconnects it from any connected nodes, and returns the removed `Node`.
* Parameters:
  * `node` (`Node`): The `Node` to remove from the graph.

### `traverse(&block)`
* Description: Traverses the graph in a topological sort order, yielding each `Node` to the given block.
* Parameters:
  * `block` (Block): The block to yield each `Node` to.

By using the `DAG` class to represent the dependencies and scheduling requirements of ETL and data processing systems, we can easily manage complex workflows and ensure that tasks are executed in the correct order.