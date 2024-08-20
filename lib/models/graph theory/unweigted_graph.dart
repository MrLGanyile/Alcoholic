import 'graph.dart';
import 'edge.dart';

class UnweigtedGraph<V> extends Graph<V>{

  UnweigtedGraph(List<V> vertices, List<Edge> edges){
    build(vertices, edges);
  }
}