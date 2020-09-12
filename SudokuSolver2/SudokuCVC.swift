////
////  homeCVC.swift
////  collectionviewtutorial
////
////  Created by Lee on 11/9/20.
////  Copyright © 2020 radev. All rights reserved.
////
//
//import UIKit
//
//private let reuseIdentifier = "Cell"
//
//class SudokuCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView?.backgroundColor = .systemRed
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 9
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 9
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        cell.backgroundColor = .systemGreen
//        cell.layer.borderWidth = 0.5
//        cell.layer.borderColor = UIColor.black.cgColor
//        
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (view.bounds.width-9)/9, height: (view.bounds.height-9)/9)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("tapped cell at \(indexPath)")
//    }
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//     // Uncomment this method to specify if the specified item should be highlighted during tracking
//     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//
//    /*
//     // Uncomment this method to specify if the specified item should be selected
//     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//     return true
//     }
//     */
//
//    /*
//     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//     return false
//     }
//
//     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//     return false
//     }
//
//     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//     }
//     */
//
//}
