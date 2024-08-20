import 'dart:collection';
import 'dart:developer';

import 'edge.dart';
import 'tree.dart';

abstract class Graph<V>{ 

  final List<V> vertices = const[]; // Store vertices
  final List<List<Edge>> neighbors = const[]; // Adjacency lists

  Graph();

  void build(List<V> vertices, List<Edge> edges){

    for(V v in vertices){
      addVertex(v);
    }

    for(Edge edge in edges){
      addEdge(edge.vIndex, edge.uIndex);
    }

  }



  int getSize(){ 
    return vertices.length;
  }

  List<V> getVertices(){
    return vertices;
  }

  V getVertex(int index){
    return vertices[index];
  }

  int getIndex(V v){
    for(int i = 0; i < vertices.length; i++){
      if(vertices[i]==v){
        return i;
      }
    }

    return -1;
  }

  List<int> getNeigbors(int vIndex){
    
    List<int> neighbors = [];

    for(Edge e in this.neighbors[vIndex]){
      neighbors.add(e.uIndex);
    }

    return neighbors;
  }

  void clear(){
    vertices.clear();
    neighbors.clear();
  }

  int getDegree(V v){

    for(int vIndex = 0; vIndex < vertices.length; vIndex++){
      if(v==vertices[vIndex]){
        return neighbors[vIndex].length;
      }
    }
    return -1;
  }

  void printEdges(){
    
    for(int v = 0; v < neighbors.length; v++){
      log('\nVertex(${vertices[v]}) Edges : ');
      for(Edge edge in neighbors[v]){
        log('(${vertices[edge.vIndex]}, ${vertices[edge.vIndex]}) ');
      }
    }
  }

  bool addVertex(V v){
    if(vertices.contains(v)){
      return false;
    }

    vertices.add(v);
    neighbors.add(<Edge>[]);
    return true;
  }

  bool addEdge(int vIndex, int uIndex){
    
    if(vIndex < vertices.length && 
    uIndex < vertices.length &&
    vIndex>=0 && uIndex>=0){
      Edge edge = Edge(vIndex: vIndex, uIndex: uIndex);
      if(!neighbors[edge.vIndex].contains(edge)){
        neighbors[edge.vIndex].add(edge);
        return true;
      }
      return false;
    }
    return false;
  }

  Tree depthFirstSearch(int vIndex){

    
    List<int> searchOrder = [];
    List<int> parent = []; // Each vertex has a single parrent.

    // Initialize all parents to -1.
    for(int i =0; i < vertices.length;i++){
      parent.add(-1);
    }

    // Mark visited vertices
    List<bool> isVisited = [];

    
    void dfs(int vIndex, List<int> parent, 
     List<int> searchOrder, List<bool> isVisited){

      // Store the visited vertex
      searchOrder.add(vIndex);
      // Mark vertex as visited
      isVisited[vIndex]= true;

      for(Edge edge in neighbors[vIndex]){
        if(!isVisited[edge.uIndex]){
          // The parent of vertex u is v
          parent[edge.uIndex] = vIndex;
          // Recursive search
          dfs(edge.uIndex, parent, searchOrder, isVisited);
        }
      }
    }

    // Recursively search
    dfs(vIndex, parent, searchOrder, isVisited);

    
    return Tree(vertices: vertices, root: vIndex, parent: 
    parent, searchOrder: searchOrder);

  }

  

  Tree breathFirstSearch(int vIndex){

    List<int> searchOrder = [];
    List<int> parent = []; // Each vertex has a single parrent.
    List<bool> isVisited = [];
    // Initialize all parents to -1.
    for(int i =0; i < vertices.length;i++){
      parent.add(-1);
    }

    final queue = LinkedList<VertexIndex>();
    // Enqueue vIndex
    queue.addFirst(VertexIndex(vertexIndex: vIndex));
    // Mark as visited
    isVisited[vIndex] = true;

    while(queue.isNotEmpty){
      // Dequeue to u
      int uIndex = queue.elementAt(0).vertexIndex;
      // uIndex searched
      searchOrder.add(uIndex);

      for(Edge edge in neighbors[uIndex]){
        if(!isVisited[edge.vIndex]){
          // Enqueue wIndex
          queue.addFirst(VertexIndex(vertexIndex:edge.vIndex));
          // The parent of wIndex is uIndex
          parent[edge.vIndex] = uIndex;
          // Mark it as visited
          isVisited[edge.vIndex] = true;
        }
      }
    }

    return Tree(vertices: vertices, root:vIndex, parent:parent, searchOrder:searchOrder);

  }

}

class VertexIndex extends LinkedListEntry<VertexIndex>{
  int vertexIndex;
  VertexIndex({required this.vertexIndex});
}