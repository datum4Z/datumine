`Node` Class

The `Node` class represents a single vertex or node in a directed acyclic graph (DAG) used for modeling ETL and data processing scheduling systems. Each `Node` contains the following attributes:

### `value`
* Type: Any
* Description: The value of the `Node`, which can be any type of object or data.

### `parents`
* Type: Array of `Node`s
* Description: The list of parent `Node`s, which represent the incoming edges of the `Node` in the DAG.

### `children`
* Type: Array of `Node`s
* Description: The list of child `Node`s, which represent the outgoing edges of the `Node` in the DAG.

The `Node` class provides the following methods:

### `initialize(value)`
* Description: Creates a new `Node` object with the given value and initializes its `parents` and `children` attributes as empty arrays.
* Parameters:
  * `value` (Any): The value of the `Node`.

### `add_parent(parent)`
* Description: Adds the given `Node` as a parent of the current `Node`.
* Parameters:
  * `parent` (`Node`): The parent `Node` to add.

### `add_child(child)`
* Description: Adds the given `Node` as a child of the current `Node`.
* Parameters:
  * `child` (`Node`): The child `Node` to add.

### `isolated?`
* Description: Returns `true` if the node is isolated (i.e., it has no parents and no children), and `false` otherwise.

By using the `Node` class to represent the tables and processing steps in the DAG, we can easily capture the dependencies and scheduling requirements of ETL and data processing systems.
