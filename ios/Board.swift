struct Board {
  // slightly tempted to make this a `let` and see where that gets to be a problem
  private(set) var cells: [[Bool]]
  
  var dimension: Int {
    return cells.count
  }
  
  // Creates a board with all cells equal to false
  init(dimension: Int) {
    cells = MakeArray2D(dimension, numPerRow: dimension, value: false)
  }
  
  init(cells: [[Bool]]) {
    self.cells = cells
  }
  
  mutating func setValue(val: Bool, atIndex index: (Int, Int)) {
    cells[index.0][index.1] = val
  }
  
  func getValue(index: (Int, Int)) -> Bool {
    let (i, j) = index
    return cells.toroidalGet(i).toroidalGet(j)
  }
  
  func countLivingNeighbors(index: (Int, Int)) -> Int {
    func neighborDeltas() -> [(Int, Int)] {
      let oneDDeltas = [-1, 0, 1]
      let pairs = oneDDeltas.cross(oneDDeltas)
      return pairs.filter { !($0.0 == 0 && $0.1 == 0) }
    }
    
    let (i, j) = index
    let delts = neighborDeltas()
    let neighborLivingStates = delts.map { (indexDeltas: (Int, Int)) -> Bool in
      let (di, dj) = indexDeltas
      let index = (i + di, j + dj)
      return getValue(index)
    }
    
    return neighborLivingStates.map { $0 ? 1 : 0 }.reduce(0, combine: +)
  }
  
  func enumerateCells(@noescape callback: (Int, Int, Bool) -> Void) {
    cells.enumerate2d(callback)
  }
}
