//
//  itemCreateNewViewController.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import FirebaseAuth


class itemCreateNewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    open var backVC : ItemsOwnViewController!
    
    @IBOutlet var photoCollection: UICollectionView!
    @IBOutlet var descriptionText: UITextView!
    @IBOutlet var nameTextField: MadokaTextField!
    open var arrayImages : [UIImage]?
    open var arrayData : [Data]?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    open func initializeArray(){
        self.arrayImages = [UIImage]()
        self.arrayData = [Data]()
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
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        descriptionText.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    
    
    
    @IBAction func createToughed(){
        //primero comprobamos que tenga nombre y alguna foto cargada
        if comprobeNameAndPhoto(){
            //si estamos aquí es pq hemos pasado las dos pruebas
            
            ULServ_Item().createItem(Auth.auth().currentUser?.uid, name: nameTextField.text!, mediaUrl: nil, description: descriptionText.text, mediaData: arrayData, completionHandlerItem: { (error, item) in
                
                if let error = error {
                    self.present(ULF_errorAlertView(error), animated: true, completion: nil)
                } else {
                    
                    self.backVC.items? = Service_LocalCoreData().itemsStored()!
                    self.backVC.itemsCollection.reloadData()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func comprobeNameAndPhoto() -> Bool{
        if nameTextField.text?.count == 0 {
            self.present(ULF_errorAlertView("Debes introducir un nombre"), animated: true, completion: nil)
            return false
        }
        if arrayImages == nil {
            self.present(ULF_errorAlertView("Debes introducir alguna foto..."), animated: true, completion: nil)
            return false
        }
        
//        pasado esto lanzamos un true
        return true
    }
    
    
    
}
