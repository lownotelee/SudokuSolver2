import Foundation

//TODO: find out why i made this a struct
struct SudokuSolver {
    private(set) var cells = [Cell]()
    
    let sizeOfSmallSquare: Int
    
    init(sizeOfPuzzle: Int, puzzleToLoad: [[Int]]) {
        // make sure the puzzle acutally exists
        assert(sizeOfPuzzle > 0, "SudokuSolver.init (\(sizeOfPuzzle)): sizeOfPuzzle can't be zero")
        
        // create variables for value and predefined, as it makes the cell init easier to read
        var value: Int?
        var predefined: Bool
        
        // iterate through the rows and columns of the provided puzzle and instanciate cells
        for row in 0..<sizeOfPuzzle {
            for column in 0..<sizeOfPuzzle {
                value = puzzleToLoad[row][column] != 0 ? puzzleToLoad[row][column] : nil
                predefined = puzzleToLoad[row][column] != 0 ? true : false
                let cell = Cell(value: value, isPredefined: predefined, row: row, column: column)
                cells += [cell]
            }
        }
        sizeOfSmallSquare = Int(sqrt(Double(sizeOfPuzzle)))
    }
    
    func solve() {
        //printSomething()
    }
    
    // test function to make something happen
    func printSomething() {
        let row = getRow(at: 2)
        for i in 0..<(row.count) {
            print("row 2 column \(i) value is \(String(describing: row[i].value))")
        }
        
        let column = getColumn(at: 2)
        for i in 0..<(column.count) {
            print("row \(i) column \(2) value is \(String(describing: column[i].value))")
        }
        
        print()
        
        let smallSquare = getSmallSquare(at: 4, and: 8)
        for i in 0..<(smallSquare.count) {
            print("SS row \(smallSquare[i].row) column \(smallSquare[i].column) value is \(String(describing: smallSquare[i].value))")
        }
    }
    
    // return all cells where the row field is equal to the index passed in
    private func getRow(at index: Int) -> [Cell] {
        return cells.filter { $0.row == index }
    }
    
    // return all cells where the column field is equal to the index passed in
    private func getColumn(at index: Int) -> [Cell] {
        return cells.filter { $0.column == index }
    }
    
    
    private func getSmallSquare(at down: Int, and across: Int) -> [Cell] {
        var holdingArray: [Cell] = []
        //figure out the starting cell for that small square. use % to find how many cells back we need to go
        let startingDown = down - (down % sizeOfSmallSquare)
        let startingAcross = across - (across % sizeOfSmallSquare)
        holdingArray = cells.filter { $0.column >= startingAcross && $0.column < (startingAcross + sizeOfSmallSquare) && $0.row >= startingDown && $0.row < (startingDown + sizeOfSmallSquare)}
        
        return holdingArray
    }
    
    //TODO: Find out why I did this as mutating. It's covered in the Stanford lectures
    mutating func findPossibilities() {
        let arrayOfPotentialNumbers: Set = [1,2,3,4,5,6,7,8,9]
        var knownNumbers: [Int] = []
        
        //interate through the cells.
        for cellIndex in 0..<(cells.count) {
            //If the cell has a value, skip over to the next one.
            if let _ = cells[cellIndex].value{
                continue
            }
            //Fill up the array with the numbers that are known
            knownNumbers =  getArrayOfKnownNumbers(for: getRow(at: cells[cellIndex].row)) +
                            getArrayOfKnownNumbers(for: getColumn(at: cells[cellIndex].column)) +
                            getArrayOfKnownNumbers(for: getSmallSquare(at: cells[cellIndex].row, and: cells[cellIndex].column))
            //Make the possibilities array equal to
            cells[cellIndex].possibilities = arrayOfPotentialNumbers.filter {!knownNumbers.contains($0)}
            print("cell is \(cells[cellIndex])")
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
