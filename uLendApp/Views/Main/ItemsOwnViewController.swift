//
//  ItemsOwnViewController.swift
//  uLendApp
//
//  Created by Manu on 23/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

final class ItemsOwnViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
//    @IBOutlet var newItemQuestionView: UIView!
    @IBOutlet var newItemButton: UIBarButtonItem!
    @IBOutlet var itemsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsCollection.delegate = self
        itemsCollection.dataSource = self
        
      
    }
}


// MARK: Collection Functions
extension ItemsOwnViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemCollectionViewCell
        
        return cell
    }
    
}


// MARK: animation functions
//extension ItemsOwnViewController {
//
//    func animateView(){
//
//        self.view.addSubview(newItemQuestionView)
//        newItemQuestionView.center = self.view.center
//        newItemQuestionView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
//        newItemQuestionView.alpha = 0
//
//        UIView.animate(withDuration: 0.33) {
//            self.newItemQuestionView.transform = CGAffineTransform.identity
//            self.newItemQuestionView.alpha = 1
//        }
//
//    }
//
//}

