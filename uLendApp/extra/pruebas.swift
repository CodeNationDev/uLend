//
//  pruebas.swift
//  uLendApp
//
//  Created by Manu on 31/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation

struct pruebasquefuncionan {
    
    
    func probandochangelabel(){
        Service_Item().updateLabelbyUidItem("0vF3ut41l5376o8JitEB", "name", "mequetrefe" as AnyObject) { (error, bool) in
            if error != nil {
                print(error!)
            } else {
                print(true)
            }
        }
    }
    
    
    func probandobusquedadeitem(){
        Service_Item().searchItem("0vF3ut41l5376o8JitEB") { (error, item) in
            if error != nil {
                print(error as Any)
            }
            guard item != nil else {
                //algo ha pasado por ahí....
                
                return
            }
        }
    }
    
    
    func probandoItemsArray(){
        Service_Item().searchItemsByOwner("A554524C-E464-42A5-9F17-F9BE2A48FF13") { (error, items) in
            if error != nil {
                print(error as Any)
            } else {
                //tenemos array :)
                print(items as Any)
            }
        }
    }
    
    
    
}
