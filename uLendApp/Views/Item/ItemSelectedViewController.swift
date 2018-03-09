//
//  ItemSelectedViewController.swift
//  uLendApp
//
//  Created by Manu on 28/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

class ItemSelectedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet var collectionImages: UICollectionView!
    
    var itemSelected: Item!
    var backVC: ItemsOwnViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        print("Estás en el item:\(itemSelected!.uid!)  ")
        
        collectionImages.delegate = self
        collectionImages.dataSource = self
    }

    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        backVC.deleteItemSelected()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = itemSelected.imagesArray?.count else {
            print("nada??")
            return 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageItem", for: indexPath) as! imagesItemCollectionViewCell
        
        cell.image.image = itemSelected.imagesArray![indexPath.row]
        
        
        return cell
    }
    
    
    
    
}
