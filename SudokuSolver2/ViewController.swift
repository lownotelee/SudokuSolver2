//
//  ViewController.swift
//  SudokuSolver2
//
//  Created by Lee on 8/2/19.
//  Copyright © 2019 radev. All rights reserved.
//

/* NOTES FROM TODAYS WORK*/
// I kinda fucked up the view a fair bit
// I'm trying to add a subview and draw the grid in there, but I can't
// figure out how to draw lines within that subview (as in, I can draw
// lines, but I can't figure out how to pass in coordinates of the lines
// I want to draw). I'm now thinking that I should be creating 81 subviews
// and drawing lines between all of them, but I think that seems like a shitty
// way of doing it.
// QUESTIONS I SHOULD HAVE ANSWERED
// What is a context for the draw function?
// How can I pass in coordinates to draw to?
// What is the CGRect that gets passed in to the draw function?


import UIKit

class ViewController: UIViewController {
    
    let bigSquare1 = [
        [3,0,0,7,0,4,0,9,0],
        [0,2,8,6,0,0,0,7,0],
        [0,0,0,0,0,0,0,1,2],
        [0,9,0,0,5,0,0,4,7],
        [0,5,6,1,0,0,9,0,0],
        [1,0,4,0,3,0,0,5,6],
        [5,0,2,4,0,8,7,0,1],
        [7,3,1,2,0,0,0,0,0],
        [4,0,0,3,0,0,2,6,0]
    ]
    
    // lazy because it can't load the count from bigSquare until after the game is initialised
    lazy var game = SudokuSolver(sizeOfPuzzle: 9 /*bigSquare1.count*/, puzzleToLoad: bigSquare1)
    
    @IBOutlet private var cellButtons: [UIButton] = []
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellsWide = bigSquare1.count
        
        putBaseSquareOn()
        putSolveButtonOn()
        createCellButtons()
        
        /*
        var targetCell: Int = 0
         
        let cellWidth = Double(frameSides/CGFloat(puzzleSize))
        
        var rowScaler: Double = 0
        var columnScaler: Double = 0
        
        for row in 0..<cellsWide {
            rowScaler = Double(row)/Double(cellsWide)
            yStartCoord = (Double(frameSides) * rowScaler) + Double(gridArea.frame.minY)
            for column in 0..<cellsWide {
                
                columnScaler = Double(column)/Double(cellsWide)
                xStartCoord = (Double(frameSides) * columnScaler) + Double(gridArea.frame.minX)
                
                let cell = UIButton(frame: CGRect(x: xStartCoord, y: yStartCoord, width: cellWidth, height: cellWidth))
                
                // if the cell to be drawn has a value, write the value in black
                if let value = game.cells[targetCell].value {
                    cell.setTitle(String(value), for: .normal)
                    cell.setTitleColor(.black, for: .normal)
                } else {    // if not, write nothing in red
                    cell.setTitle("", for: .normal)
                    cell.setTitleColor(.red, for: .normal)
                }
                
                targetCell += 1
                
                cell.addTarget(self, action: #selector(cellButtonAction), for: .touchUpInside)
                cellButtons.append(cell)
                self.view.addSubview(cell)
            }
        }*/
    }
    
    func putSolveButtonOn() {
        let solveButton = UIButton(frame: CGRect(x: (screenSize.width/2)-50, y: 600, width: 100, height: 50))
        solveButton.backgroundColor = .blue
        solveButton.setTitleColor(.white, for: .normal)
        solveButton.setTitle("Solve!", for: .normal)
        solveButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(solveButton)
    }
    
    let baseSquare = BaseSquare(9)
    
    func createCellButtons() {
        let boardWidth = baseSquare.frame.minX
        print("minX is \(baseSquare.frame.minX), maxX is \(baseSquare.frame.maxX)")
    }
    
    func putBaseSquareOn() {
        view.addSubview(baseSquare)
        baseSquare.translatesAutoresizingMaskIntoConstraints = false
        
        let offSet: CGFloat = view.bounds.width * (0.05)
        
        NSLayoutConstraint.activate([
            baseSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            baseSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            baseSquare.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offSet),
            baseSquare.heightAnchor.constraint(equalTo: self.view.widthAnchor, constant: (offSet * -2))
        ])
    }
    
    func updateCell() {
        print("fucklallla")
        print(cellButtons[21])
    }
    
    @objc func cellButtonAction(sender: UIButton!) {
        if let cellNumber = cellButtons.firstIndex(of: sender) {
            print("cellNum is \(cellNumber), value of cell is \(String(describing: game.cells[cellNumber].value))")
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        game.solve()
    }
}
