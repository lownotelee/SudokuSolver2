//
//  GridView.swift
//  SudokuSolver2
//
//  Created by Lee on 21/3/20.
//  Copyright © 2020 radev. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    func addLine(fromPoint start: CGPoint, toPoint end: CGPoint, line thickness: Int) {
        //let context = UIGraphicsGetCurrentContext()
        
    }

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(UIColor.green.cgColor)
        context.fill(bounds)
    }
}
