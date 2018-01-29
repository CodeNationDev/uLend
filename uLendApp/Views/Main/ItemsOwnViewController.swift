//
//  ItemsOwnViewController.swift
//  uLendApp
//
//  Created by Manu on 23/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

final class ItemsOwnViewController: UIViewController {

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        probandobusquedadeitem()
        probandoItemsArray()

        
      
    }


    
    
    func probandobusquedadeitem(){
        Service_Item().searchItem("0vF3ut41l5376o8JitEB") { (error, item) in
            if error != nil {
                print(error)
            }
            guard let item = item else {
                //algo ha pasado por ahí....
                
                return
            }
        }
    }
    
    
    func probandoItemsArray(){
        Service_Item().searchItemsByOwner("A554524C-E464-42A5-9F17-F9BE2A48FF13") { (error, items) in
            if error != nil {
                print(error)
            } else {
                //tenemos array :)
            }
        }
    }
    
    
    

}
