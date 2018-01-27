//
//  Item.swift
//  uLendApp
//
//  Created by Manu on 22/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation



final class Item {
    
    var uid: String?
    var uidOwner: String?
    var name: String?
    var description: String?
    
    
    var images: [String]?
    var geoposition: GeoPosition?
    
    
    
    
    
    
}


extension Item {
    
 
    func createAlgoliaData() -> Profile?{
        
        
        var data = Profile()

        guard let uid = self.uid else {
            return nil
        }
        guard let uidOwner = self.uidOwner else {
            return nil
        }
        guard let name = self.name else {
            return nil
        }
        
        data["uid"] = uid as AnyObject
        data["uidOwner"] = uidOwner as AnyObject
        data["name"] = name as AnyObject
        
        // if geoposition exists add data
        if geoposition != nil {
            data["_geoloc"] = geoposition?.dataGeoposition() as AnyObject
        }
        
        return data
    }
}
