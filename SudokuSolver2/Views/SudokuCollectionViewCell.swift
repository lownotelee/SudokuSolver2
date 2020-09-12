//
//  SudokuCollectionViewCell.swift
//  SudokuSolver2
//
//  Created by Lee on 11/9/20.
//  Copyright © 2020 radev. All rights reserved.
//

import UIKit

class SudokuCollectionViewCell: UICollectionViewCell {
    
    var cellText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        putTextOnCell()
        configureTextLayout()
    }
    
    init (cellNumber: String, textColor: UIColor) {
        super.init(frame: .zero)
        
        putTextOnCell()
        self.cellText.text = cellNumber
        self.cellText.textColor = textColor
        self.backgroundColor = .systemTeal
        configureTextLayout()
        
    }
    
    func putTextOnCell() {
        self.addSubview(cellText)
        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellText.backgroundColor = .tertiarySystemBackground

        NSLayoutConstraint.activate([
            cellText.topAnchor.constraint(equalTo: self.topAnchor),
            cellText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellText.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func configureTextLayout() {
        cellText.font = UIFont.preferredFont(forTextStyle: .body)
        cellText.lineBreakMode = .byTruncatingTail
        cellText.textAlignment = .center
        cellText.numberOfLines = 1
        cellText.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
