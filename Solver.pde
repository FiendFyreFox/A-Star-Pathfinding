import java.util.ArrayList;
import java.util.PriorityQueue; 
import java.util.Collections;
import java.util.Random;

public class Solver {

  public ArrayList<Node> allNodes;
  public  ArrayList<Node> closed;
  public ArrayList<Node> explored;
  PriorityQueue<Node> open;
  
  
  public Solver(int[][] wallStruct) {
    // this.allNodes = all;
    this.closed = new ArrayList<Node>();
    this.explored = new ArrayList<Node>();
    open = new PriorityQueue<Node>();
    
    closed.clear();
    
    
    for (int x = 0; x < rows; x++) {
      for (int y = 0; y < cols; y++) {
        if ( wallStruct[x][y] == 0 && x != endX && y != endY) {
          closed.add(nodeGrid[x][y]);
        }
      }
    }
  }
  
  
  // The core method of the algorithm, which returns an arraylist containing the path
  public ArrayList<Node> getPath(Node Start, Node Destination) {
    
    // closed.clear();
    open.clear();
    explored.clear();
    
    ArrayList<Node> path = new ArrayList<Node>();
    
    Node currentNode = Start;
    currentNode.G = 0;
    open.add(currentNode);
    // print("pathfinding from " + Start.getX() + ", " + Start.getY() + " to " + Destination.getX() + " " + Destination.getY());
    
    while (true) {
      
      // if (open.contains(Destination)) {print("\nDestination is open, with a cost of " + Destination.calcCostF());}
      
      
      if (currentNode.equals(Destination) || open.contains(Destination)) {
        break;
      } else if (open.isEmpty()) {
        break;
      } else {
        
        
        // get the node with the lowest f score
        currentNode = open.remove();
        
        // print("removed node at " + currentNode.getX() + ", " + currentNode.getY() + ", which has an f score of " + currentNode.calcCostF() + "\n");
        
        // add to closed list
        closed.add(currentNode);
        
        // add all neighbors to the open queue
        for (int i = 0; i < currentNode.neighbors.size(); i++) {
          Node neighbor = currentNode.neighbors.get(i);
          
          
          
          if (closed.contains(neighbor)) {
            //print("obstacle detected!\n");
            //open.remove(neighbor);
            continue;
          }
          
          if (!open.contains(neighbor)) {
            if(MazeGrid[neighbor.getX()][neighbor.getY()] == 0 && neighbor != Destination) {continue;}
            neighbor.G = currentNode.G + 10;
            neighbor.calcCostH(Destination);
            neighbor.calcCostF();
            open.add(neighbor);
            neighbor.setParent(currentNode);
            explored.add(neighbor);
            
            
          } else if (neighbor.G <= currentNode.G) {
            // print("Node was unavailable");
            continue;
          } else if (neighbor.G > currentNode.G) {
            neighbor.setParent(currentNode);
          }
          
          
          
          
          neighbor.calcCostH(Destination);
          neighbor.calcCostF();       
        }
        
      }
    
    }
    
    if (!open.contains(Destination)) {
      print ("\n\nNo path available.\n\n");
    } else {
    Node currentRetrace = Destination;
    
    while (!Start.equals(currentRetrace)) {
      
      if (currentRetrace.getParent() == null) {
        print("the node had no parent");
        path.add(Start);
        break;
      }
      
      
      // print("the node's parent was " + currentRetrace.getParent().getX() + ", " + currentRetrace.getParent().getY() + "\n");
      if (path.contains(currentRetrace)) {
        print("wono");
        break;
      }
      
      path.add(currentRetrace);
    
      currentRetrace = currentRetrace.getParent();
    }
    
  }
  return path;
}

  public void UpdateWalls(int[][] Grid) {
    closed.clear();
    explored.clear();
    open.clear();
    for (int x = 0; x < rows; x++) {
      for (int y = 0; y < cols; y++) {
        if ( Grid[x][y] == 0 && x != endX && y != endY) {
          closed.add(nodeGrid[x][y]);
        } else if (Grid[x][y] == 1 && closed.contains(nodeGrid[x][y])) {
          closed.remove(nodeGrid[x][y]);
        }
      }
    }
  }
}
