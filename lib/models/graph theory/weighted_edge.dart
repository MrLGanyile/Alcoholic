import 'edge.dart';

class WeightedEdge  extends Edge implements Comparable<WeightedEdge>{

  double weight;

  WeightedEdge({
    required vIndex,
    required uIndex,
    required this.weight,
  }): super(vIndex:vIndex, uIndex:uIndex);
  
  @override
  int compareTo(WeightedEdge other) {
   
    if(weight<other.weight){
      return -1;
    }
    else if(weight>other.weight){
      return 1;
    }
    return 0;
  }
}