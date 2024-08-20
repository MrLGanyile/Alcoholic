import 'graph.dart';
import 'weighted_edge.dart';

class WeigtedGraph<V> extends Graph<V>{

  WeightedGraph(List<V> vertices, List<WeightedEdge> edges){
    build(vertices, edges);
  }
}