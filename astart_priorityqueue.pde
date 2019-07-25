int cols = 100;
int rows = 100;
int GridSize = 20;
int startX = 99;
int startY = 49;
int endX = 0;
int endY = 49;
boolean canMoveDiag = false;

int[][] MazeGrid = new int[cols][rows];
Solver mazeSolver;

Node nodeGrid[][] = new Node[rows][cols];
// Node startNode = new Node(0, 0);
// Node endNode = new Node(9, 9);




void setup() {
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
    
      nodeGrid[r][c] = new Node(r, c);
      // print("Node at " + r + ", " + c + " initialized.");
      // print(nodeGrid);
    }
  }
  
  size(2000, 2000);
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      if((j == startX && i == startY) || (j == endX && i == startY)) {
        MazeGrid[i][j] = 1;
      } else {
        MazeGrid[i][j] = round(random(0.2, 1));
      }
    }
  }
  
  mazeSolver = new Solver(MazeGrid);
  
  
  
 for (int r = 0; r < rows; r++) {
  for (int c = 0; c < cols; c++) {
    Node n = nodeGrid[r][c];
    ArrayList<Node> neighbors = n.neighbors;
    if (c > 0) {     // has west
      if (nodeGrid[r][c-1].getParent() == null) {
        nodeGrid[r][c-1].setParent(n);
      }
      neighbors.add(nodeGrid[r][c-1]);
    }
    if (c < cols - 1) { // has east
      if (nodeGrid[r][c+1].getParent() == null) {
        nodeGrid[r][c+1].setParent(n);
      }
      neighbors.add(nodeGrid[r][c+1]);
    }
    if (r > 0) {     // has north
      if (nodeGrid[r-1][c].getParent() == null) {
        nodeGrid[r-1][c].setParent(n);
      }
      
      neighbors.add(nodeGrid[r-1][c]);
    }
    if (r < rows - 1) { // has south
      if (nodeGrid[r+1][c].getParent() == null) {
        nodeGrid[r+1][c].setParent(n);
      }
      neighbors.add(nodeGrid[r+1][c]);
    }
    if (canMoveDiag) {
      if (c > 0 && r > 0) { // has northwest
        neighbors.add(nodeGrid[r-1][c-1]);
      }
      if (c > 0 && r < rows - 1){ // has southwest
        neighbors.add(nodeGrid[r+1][c-1]);
      }
      if (c < cols - 1 && r > 0) { // has northeast
        neighbors.add(nodeGrid[r-1][c+1]);
      }
      if (c < cols - 1 && r < rows - 1) { // has southeast
        neighbors.add(nodeGrid[r+1][c+1]);
      }
    }
   }
  }
  
  
  ArrayList<Node> Path = new ArrayList<Node>();
  Path = mazeSolver.getPath(nodeGrid[startX][startY], nodeGrid[endX][endY]);
  if (Path.size() > 0) {
    print("The path was " + Path.size() + " nodes long. \n");
  }
  print(mazeSolver.explored.size() + " nodes were explored \n");
  print(nodeGrid[2][2].calcCostF() + "  " + nodeGrid[2][2].H);
  
  for (int z = 0; z < mazeSolver.explored.size(); z++) {
    MazeGrid[mazeSolver.explored.get(z).getX()][mazeSolver.explored.get(z).getY()] = 9;
  }
  
  for (int y = 0; y < Path.size(); y++) {
    MazeGrid[Path.get(y).getX()][Path.get(y).getY()] = 5;
  }
  
  
}


void draw() {
  if (mousePressed && mouseX > 0 && mouseY > 0) {
    if (keyPressed && key == CODED && keyCode == SHIFT)  {
      MazeGrid[round(mouseX/GridSize)-1][round(mouseY/GridSize)-1] = 1;
      
    } else if (keyPressed && key == 's') {
      startX = round(mouseX/GridSize)-1;
      startY = round(mouseY/GridSize)-1;
    } else if (keyPressed && key == 'e') {
      endX = round(mouseX/GridSize)-1;
      endY = round(mouseY/GridSize)-1;
    } else {
      MazeGrid[round(mouseX/GridSize)-1][round(mouseY/GridSize)-1] = 0;
    }
    ResetGrid();
    Pathfind();
  }
  
  
  
  for (int y = 0; y < cols; y++) {
    for (int x = 0; x < rows; x++) {
      if (x == startX && y == startY) {
        fill(255, 0, 0);
      }else if (x == endX && y == endY) {
        fill(0, 255, 0);
      }else if (MazeGrid[x][y] == 9 && MazeGrid[x][y] != 0) {
        fill(100, 100, 255);
      }else if (MazeGrid[x][y] == 5) {
        fill(0, 0, 255);
      }else {
        fill(MazeGrid[x][y]*100);
      }
      square(x*GridSize, y*GridSize, GridSize);
      
      /*textSize(32);
      text(nodeGrid[round(mouseX/100)][round(mouseY/100)].getF(), (round(mouseX/100)+ 0.5)*100, (round(mouseY/100)+ 0.5)*100);*/
     }
  }
}

public void Pathfind() {
  mazeSolver.UpdateWalls(MazeGrid);
  ArrayList <Node> temppath = new ArrayList<Node>();
  temppath = mazeSolver.getPath(nodeGrid[startX][startY], nodeGrid[endX][endY]);
  
  for (int z = 0; z < mazeSolver.explored.size(); z++) {
    MazeGrid[mazeSolver.explored.get(z).getX()][mazeSolver.explored.get(z).getY()] = 9;
  }
  
  for (int y = 0; y < temppath.size(); y++) {
    MazeGrid[temppath.get(y).getX()][temppath.get(y).getY()] = 5;
  }
  // print("The path was " + temppath.size() + " nodes long. \n");
}

public void ResetGrid() {
  for (int y = 0; y < cols; y++) {
    for (int x = 0; x < rows; x++) {
      if (MazeGrid[x][y] == 9 || MazeGrid[x][y] == 5) {
        MazeGrid[x][y] = 1;
      }
    }
  }
}
