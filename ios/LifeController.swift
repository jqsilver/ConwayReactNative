import Foundation

@objc(LifeController)
class LifeController: NSObject {
  // TODO: try making a Stream of states using one/each of the FRP libraries
  
  func nextBoard(board: Board) -> Board {
    var next = Board(dimension: board.dimension)
    board.enumerateCells { (i, j, isAlive) in
      let index = (i, j)
      let numNeighbors = board.countLivingNeighbors(index)
      let aliveNext = liveOrDie(board.getValue(index), numNeighbors: numNeighbors)
      next.setValue(aliveNext, atIndex: index)
    }
    return next
  }
  
  @objc func nextBoardAsync(cells: [[Bool]], completion:([[[Bool]]] -> Void)) {
    let board = Board(cells: cells)
    let nextCells = nextBoard(board).cells
    print("siena")
    print(nextCells)
    completion([nextCells])
  }
  
  func liveOrDie(alive: Bool, numNeighbors: Int) -> Bool {
    switch numNeighbors {
    case 2:
      return alive
    case 3:
      return true
    default:
      return false
    }
  }
}

