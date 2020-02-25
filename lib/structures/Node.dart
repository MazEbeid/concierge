class Node {
  Node(this.id);
  final String id;
  double distance = double.infinity;
  String predecessor = "";
  List<Node> neighbours;
}
