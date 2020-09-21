import Foundation

protocol SudokuSolverProtocol {
    func setValueOfCell(atRow row: Int, column: Int, withValue value: Int)
}

//TODO: find out why i made this a struct
class SudokuSolver {
    private(set) var cells = [Cell]()
    
    var delegate: SudokuSolverProtocol?
    
    let sizeOfSmallSquare: Int
    
    init(sizeOfPuzzle: Int, puzzleToLoad: [[Int]]) {
        /// make sure the puzzle acutally exists
        assert(sizeOfPuzzle > 0, "SudokuSolver.init (\(sizeOfPuzzle)): sizeOfPuzzle can't be zero")
        
        /// create variables for value and predefined, as it makes the cell init easier to read
        var value: Int?
        var predefined: Bool
        
        
        /// iterate through the rows and columns of the provided puzzle and instanciate cells
        for row in 0..<sizeOfPuzzle {
            for column in 0..<sizeOfPuzzle {
                value = puzzleToLoad[row][column] != 0 ? puzzleToLoad[row][column] : nil
                predefined = puzzleToLoad[row][column] != 0 ? true : false
                let cell = Cell(value: value, isPredefined: predefined, row: row, column: column)
                cells.append(cell)
            }
        }
        sizeOfSmallSquare = Int(sqrt(Double(sizeOfPuzzle)))
    }
    
    func solve() {
        //var changeMade = false
        
        //var indexOfFirstEmptyCell = cells.firstIndex(where: { $0.value == nil })
        //var indexOfLastEmptyCell  = cells.lastIndex(where:  { $0.value == nil })
        
        findPossibilities()
        
        performExclusiveSearch()
        print("got out")
        for cell in cells {
            print(cell.possibilities.count)
        }
        
        
    }
    
    func performExclusiveSearch() {
        for (index, cell) in cells.enumerated() where (cell.possibilities.count == 1 && cell.value == nil) {
            setValueOfCell(atRow: cell.row, column: cell.column, withValue: cell.possibilities[0])
            updatePossibilities(for: cells[index])
            //print("looping again")
            performExclusiveSearch()
        }
    }
    
    // TODO: I feel I should probably throw an error or something if there is more than 1 found cell
    func getValueOfCellAt(row: Int, column: Int) -> Int? {
        let foundCell = cells.filter {$0.row == row && $0.column == column}
        guard foundCell.count == 1 else {
            return nil
        }
        return foundCell[0].value
    }
    
    // TODO: I feel I should probably throw an error or something if there is more than 1 found cell
    func getPredefinedStatusOfCell(at row: Int, column: Int) -> Bool {
        let foundCell = cells.filter {$0.row == row && $0.column == column}
        guard foundCell.count == 1 else {
            return false
        }
        return foundCell[0].isPredefined
    }
    
    func setValueOfCell(atRow row: Int, column: Int, withValue value: Int) {
        if let cellIndex = cells.firstIndex(where: {$0.row == row && $0.column == column}) {
            cells[cellIndex].value = value
            if let delegate = delegate {
                DispatchQueue.main.async {
                    delegate.setValueOfCell(atRow: row, column: column, withValue: value)
                }
                
            }
        } else {
            print("couldn't set value \(value) at row \(row) and column \(column)")
        }
    }
    
    /// return all cells where the row field is equal to the index passed in
    private func getRow(at index: Int) -> [Cell] {
        return cells.filter { $0.row == index }
    }
    
    /// return all cells where the column field is equal to the index passed in
    private func getColumn(at index: Int) -> [Cell] {
        return cells.filter { $0.column == index }
    }
    
    
    private func getSmallSquare(at down: Int, and across: Int) -> [Cell] {
        var holdingArray: [Cell] = []
        /// figure out the starting cell for that small square. use % to find how many cells back we need to go
        let startingDown = down - (down % sizeOfSmallSquare)
        let startingAcross = across - (across % sizeOfSmallSquare)
        holdingArray = cells.filter { $0.column >= startingAcross && $0.column < (startingAcross + sizeOfSmallSquare) && $0.row >= startingDown && $0.row < (startingDown + sizeOfSmallSquare)}
        
        return holdingArray
    }
    
    private func cellIsPartOfNeighbour(changedCell: Cell, comparedCell: Cell) -> Bool {
        if (changedCell.row == comparedCell.row) || (changedCell.column == comparedCell.column) {
            return true
        }
        
        var holdingArray: [Cell] = []
        /// figure out the starting cell for that small square. use % to find how many cells back we need to go
        let startingDown = comparedCell.row - (comparedCell.row % sizeOfSmallSquare)
        let startingAcross = comparedCell.column - (comparedCell.column % sizeOfSmallSquare)
        holdingArray = cells.filter { $0.column >= startingAcross && $0.column < (startingAcross + sizeOfSmallSquare) && $0.row >= startingDown && $0.row < (startingDown + sizeOfSmallSquare)}
        if holdingArray.contains(changedCell) {
            return true
        }
        return false
    }
    
    private func updatePossibilities(for changedCell: Cell) {
        //print(changedCell)
        for (index, cell) in cells.enumerated() where (cellIsPartOfNeighbour(changedCell: changedCell, comparedCell: cell) && cell.value == nil) {
            cells[index].possibilities.removeAll{$0 == changedCell.value!}
        }
    }
    
    /// Mutating because it changes the set of cells
    private func findPossibilities() {
        // TODO: Test this section, i changed the size of the array from hard coded to calculated
        let arrayOfPotentialNumbers: Set = Set(1...(sizeOfSmallSquare * sizeOfSmallSquare))
        var knownNumbers: [Int] = []
        
        /// iterate through the cells.
        for cellIndex in 0..<(cells.count) {
            /// If the cell has a value, skip over to the next one.
            if let _ = cells[cellIndex].value{
                continue
            }
            /// Fill up the array with the numbers that are known
            knownNumbers =  getArrayOfKnownNumbers(for: getRow(at: cells[cellIndex].row)) +
                getArrayOfKnownNumbers(for: getColumn(at: cells[cellIndex].column)) +
                getArrayOfKnownNumbers(for: getSmallSquare(at: cells[cellIndex].row, and: cells[cellIndex].column))
            /// Make the possibilities array equal to
            cells[cellIndex].possibilities = arrayOfPotentialNumbers.filter {!knownNumbers.contains($0)}
        }
    }
    
    private func updatePossibilitiesForRow(for changedCell: Cell) {
        
        for (index, cell) in cells.enumerated() {
            if cell.row == changedCell.row {
                cells[index].possibilities.removeAll{$0 == changedCell.value}
            }
        }
        
        
        if let value = changedCell.value {
            for index in (0..<cells.count) {
                if (cells[index].row == changedCell.row) && (cells[index].possibilities.contains(value)){
                    cells[index].possibilities.removeAll{$0 == value}
                }
            }
        } else {
            print("cell has no value, how'd you get here?")
        }
    }
    
    // returns an array of known numbers given an array of cells. Used by findPossibilities
    // TODO: convert to Set instead of Array
    private func getArrayOfKnownNumbers(for cells: [Cell]) -> [Int] {
        var arrayOfNumbers: [Int] = []
        for i in 0..<(cells.count) {
            if let foundNumber = cells[i].value {
                arrayOfNumbers.append(foundNumber)
            }
        }
        return arrayOfNumbers
    }
}
