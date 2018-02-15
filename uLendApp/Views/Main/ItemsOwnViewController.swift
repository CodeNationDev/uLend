//
//  ItemsOwnViewController.swift
//  uLendApp
//
//  Created by Manu on 23/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

final class ItemsOwnViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
    @IBOutlet var sideMenu: UIView!
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



//MARK: animation functions
extension ItemsOwnViewController {
    
    
    func hideSideMenu(){
        UIView.animate(withDuration: 0.5) {
            
            self.sideMenu.center = CGPoint(x: self.sideMenu.center.x - 60, y: self.sideMenu.center.y)
        }
    }
    
    func showSideMenu(){
        UIView.animate(withDuration: 0.5) {
            self.sideMenu.center = CGPoint(x: self.sideMenu.center.x + 60, y: self.sideMenu.center.y)
            print("hola caracola")
        }
    
    }
    
    
    
    
}



