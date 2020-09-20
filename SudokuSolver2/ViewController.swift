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
    
    let cvc: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SudokuCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    //    let bigSquare1 = [
    //        [3,0,0,7,0,4,0,9,0],
    //        [0,2,8,6,0,0,0,7,0],
    //        [0,0,0,0,0,0,0,1,2],
    //        [0,9,0,0,5,0,0,4,7],
    //        [0,5,6,1,0,0,9,0,0],
    //        [1,0,4,0,3,0,0,5,6],
    //        [5,0,2,4,0,8,7,0,1],
    //        [7,3,1,2,0,0,0,0,0],
    //        [4,0,0,3,0,0,2,6,0]
    //    ]
    //
    var game: SudokuSolver
    
    let screenSize = UIScreen.main.bounds
    
    init(puzzleToLoad: [[Int]]) {
        
        
        game = SudokuSolver(sizeOfPuzzle: 9 /*bigSquare1.count*/, puzzleToLoad: puzzleToLoad)
        
        super.init(nibName: nil, bundle: nil)
        
        game.delegate = self
        
        //ViewController.delegate = self
        
        cvc.delegate = self
        cvc.dataSource = self
    }
    
//    func loadUpCellsToCVC() {
//        var indexPath = IndexPath(item: 0, section: 0)
//        for sudokuCell in game.cells {
//            indexPath.item = sudokuCell.column
//            indexPath.section = sudokuCell.row
//        }
//        cvc.reloadData()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setCVCConstraints()
        putSolveButtonOn()
        updateSomeCell()
    }
    
    // TODO: Create a custom button and put the button on using constraints
    func putSolveButtonOn() {
        let solveButton = UIButton(frame: CGRect(x: (screenSize.width/2)-50, y: 600, width: 100, height: 50))
        solveButton.backgroundColor = .blue
        solveButton.setTitleColor(.white, for: .normal)
        solveButton.setTitle("Solve!", for: .normal)
        solveButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(solveButton)
    }
    
    func updateSomeCell() {
        
        //print(game!.cells[3])
    }
    
    func setCVCConstraints() {
        view.addSubview(cvc)
        
        let offSet: CGFloat = view.bounds.width * (0.05)
        
        NSLayoutConstraint.activate([
            cvc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cvc.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cvc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offSet),
            cvc.heightAnchor.constraint(equalTo: self.view.widthAnchor, constant: (offSet * -2))
        ])
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        game.solve()
    }
}

extension ViewController: SudokuSolverProtocol {
    func setValueOfCell(atRow row: Int, column: Int, withValue value: Int) {
        let indexPath = IndexPath(item: column, section: row)
        cvc.reloadItems(at: [indexPath])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvc.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SudokuCollectionViewCell
        
        if let cellValue = game.getValueOfCellAt(row: indexPath.section, column: indexPath.item) {
            cell.cellText.text = String(cellValue)
        } else {
            cell.cellText.text = ""
        }
        cell.cellText.textColor = game.getPredefinedStatusOfCell(at: indexPath.section, column: indexPath.row) ? .black : .systemBlue
                
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cvc.bounds.width/9, height: cvc.bounds.width/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped cell at \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
