// Definition of a Cell type. Contains;
// - an array of possibilities (which gets cleared when the value is set)
// - the value of the cell. The cell could have no value, so it's an optional. Setting it removes all possibilities with the didSet function
// - isPredefined will mean I can change the colour of it when drawing

import Foundation

struct Cell {
    var possibilities: [Int]
    var value: Int? {
        didSet {
            self.possibilities.removeAll()
        }
    }
    let isPredefined: Bool
    let row: Int
    let column: Int
    
    init(value: Int?, isPredefined: Bool, row: Int, column: Int) {
        self.value = value
        self.isPredefined = isPredefined
        self.row = row
        self.column = column
        self.possibilities = []
    }
}

// UICollectionView
