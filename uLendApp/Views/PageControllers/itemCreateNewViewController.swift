//
//  itemCreateNewViewController.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

class itemCreateNewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
    @IBOutlet var prueba: UIImageView!
    
    @IBOutlet var photoCollection: UICollectionView!
    
    open var arrayImages : [UIImage]?
//    open var arrayImages : [UIImage] = [UIImage]()
    open var imagescount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    open func initializeArray(){
        self.arrayImages = [UIImage]()
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vc = segue.destination as? CameraViewController {
            vc.backVC = self
        }
        
    }

}



extension itemCreateNewViewController {
    
    open func reloadCollection(){
        photoCollection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrayImages != nil {
            if arrayImages!.count < 3 {
                return arrayImages!.count + 1
            } else {
                return 3   //este es el mázimo de cells que se crearán
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewItemImageCell", for: indexPath) as! NewItemImageCell
        
        
        //el array no tiene ninguna imagen
        if arrayImages?.count == nil {
            return cell
        }
        // el array tiene imágenes
        // única forma que no se posione en un nil del array
        if indexPath.row != arrayImages?.count {
            cell.backGround.image = arrayImages?[indexPath.row]
            return cell
        }
        return cell
    }
    
}
