class Edge{
  int vIndex;
  int uIndex;

  Edge({
    required this.vIndex,
    required this.uIndex,
  });

  
  bool equals(Edge other){
    return uIndex==other.uIndex && vIndex==other.vIndex;
  }
}