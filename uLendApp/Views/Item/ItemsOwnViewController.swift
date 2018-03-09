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
    var items : [Item]?
    var itemSelected: Item?
    var rowItemSelected : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsCollection.delegate = self
        itemsCollection.dataSource = self
        items = Service_LocalCoreData().itemsStored()
        itemsCollection.reloadData()
    }
}





// MARK: Collection Functions
extension ItemsOwnViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items!.count)
        return (items?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemCollectionViewCell
        
        let item = items![indexPath.row]
        let images = Service_LocalCoreData().imagesByUIDimage(item.uid)
        
        item.imagesToItem(images!)
        
        guard let image = UIImage(data: (images?.last!)!) else {
            return cell
        }
        cell.image.image = image
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelected = items![indexPath.row]
        rowItemSelected = indexPath.row
        performSegue(withIdentifier: "showItem", sender: nil)

    }
    
    func deleteItemSelected(){
        //eliminamos de Firebase
        
        ULServ_Item().deleteItem(itemSelected!) { (error, bool) in
            if let error = error {
                print(error)
            } else {
                // se ha borrado correcto, así que ahora lo eliminamos de coredata y del oollection
                Service_LocalCoreData().removeItem(self.itemSelected!)
                
                if self.rowItemSelected != nil {
                    self.items?.remove(at: self.rowItemSelected!)
                    self.itemsCollection.reloadData()
                    self.itemSelected = nil
                    self.rowItemSelected = nil
                }
            }
        }
        
        
        
        

    }

    
}







extension ItemsOwnViewController {
    
    //MARK: animation functions
    func hideSideMenu(){
        UIView.animate(withDuration: 0.5) {
            self.sideMenu.center = CGPoint(x: self.sideMenu.center.x - 60, y: self.sideMenu.center.y)
        }
    }
    
    func showSideMenu(){
        UIView.animate(withDuration: 0.5) {
            self.sideMenu.center = CGPoint(x: self.sideMenu.center.x + 60, y: self.sideMenu.center.y)
        }
    }
    
    
    
    //MARK: preparesegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? itemCreateNewViewController {
            vc.backVC = self
        }
        if let vc = segue.destination as? ItemSelectedViewController {
            vc.backVC = self
            vc.itemSelected = itemSelected!
        }
        
//        if let vc = segue.destination as? ItemSelectedViewController {
//            vc.hola = "caracola"
//        }
//        if segue.identifier == "showItem" {
////            let vc = segue.destination as?
//        }
    }
    
    
    
    
}



