import java.util.*;
import java.util.PriorityQueue;

class Node implements Comparable<Node> {
  
  int H;
  int F;
  int G;
  public Node Parent;
  ArrayList<Node> neighbors = new ArrayList<Node>();
  
  int X;
  int Y;
  public Node(int xPos, int yPos) {
    
    X = xPos;
    Y = yPos;
    
    Parent = null;
    
    // G = ParentCost + 1;
    // H = temp_H;
  }
  
  public int getX() {
    return X;
  }
  
  public int getY() {
    return Y;
  }
  
  public int getF() {
    return F;
  }
  
  public void setParent(Node _Parent) {
    Parent = _Parent;
  }
  
  public Node getParent() {
    return Parent;
  }

  public void calcCostH(Node Destination) {
  
    int D = 10;
    int D2 = 14;
    
    int dx = abs(X - Destination.getX());
    int dy = abs(Y - Destination.getY());
    H = D * (dx + dy) + (D2 - 2 * D) * min(dx, dy);
    
  }
  
  public int calcCostF() {

  F = G + H;
  return F;

  }
  
  public int compareTo(Node employee) {
        if(this.calcCostF() > employee.calcCostF()) {
            return 1;
        } else if (this.calcCostF() < employee.calcCostF()) {
            return -1;
        } else {
            return 0;
        }
    }
  

}
