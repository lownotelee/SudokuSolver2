//
//  CellView.swift
//  SudokuSolver2
//
//  Created by Lee on 11/9/20.
//  Copyright © 2020 radev. All rights reserved.
//

import UIKit

class CellView: UIView {
    
    let cellText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (cellNumber: String, textColor: UIColor) {
        super.init(frame: .zero)
        self.addSubview(cellText)
        self.cellText.text = cellNumber
        self.cellText.textColor = textColor
        configureTextLayout()
    }

    func configureTextLayout() {
        cellText.font = .systemFont(ofSize: 12, weight: .regular)
        cellText.textAlignment = .center
        cellText.numberOfLines = 1
        cellText.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
