class Tree<V>{
  int root; // The root of the tree
  List<int> parent; // Store the parent of each vertex.
  List<int> searchOrder; // Store the search order.
  List<V> vertices;

  Tree({
    required this.root,
    required this.parent,
    required this.searchOrder,
    required this.vertices,
  });

  int getParent(int vIndex){
    return parent[vIndex];
  }

  int getNumberOfVerticesFound(){
    return searchOrder.length;
  }

  List<V> getPath( int index) {
    List<V> path = [];

    do{
      path.add(vertices[index]);
      index = parent[index];
    }while(index != -1);

    return path;
  }

  void printPath(int index){

  }

  void printTree() {

  }
}