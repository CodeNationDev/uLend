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
        
        guard let image = UIImage(data: (images?.last!)!) else {
            return cell
        }
        cell.image.image = image
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItem", sender: nil)
//        ULServ_Item().deleteItem(items![indexPath.row]) { (error, bool) in
//            if error != nil {
//                self.present(ULF_errorAlertView("Ha ocurrido un error, vuelve a probar"), animated: true, completion: nil)
//            } else {
//
//                for x in 1...3  {
//                    ULServ_Storege().itemImagesRef.child(self.items![indexPath.row].uid!).child("image\(x).jpg").delete(completion: { (error) in
//                        if let error = (error as NSError?){
//                            print(error.localizedDescription)
//                        }
//                    })
//                }
//                
//                Service_LocalCoreData().removeItem(self.items![indexPath.row])
//                self.items?.remove(at: indexPath.row)
//                self.itemsCollection.reloadData()
//            }
//        }
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? itemCreateNewViewController {
            vc.backVC = self
        }
    }
    
    
    
    
}


