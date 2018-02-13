//
//  Item.swift
//  uLendApp
//
//  Created by Manu on 22/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase



final class Item {
    
    var uid: String?
    var uidOwner: String?
    var name: String?
    var description: String?
    var images: [String]?
    var geoposition: GeoPosition?
    
    
    var country: String?
    
    
    init(){}
    
    
     
    init(document: DocumentSnapshot!){

        self.uid = document.documentID
        self.uidOwner = document.get("uidOwner") as? String
        self.name = document.get("name") as? String
        self.description = document.get("description") as? String ?? ""
        
        if let geo = document.get("_geoloc") as? Dictionary<String, Double> {
            self.geoposition = GeoPosition(geo["lng"]!, geo["lat"]!)
        }
        
        
//        self.uidOwner = document.data()?["uidOwner"] as? String
//        self.name = document.data()?["name"] as? String
//        self.description = document.data()?["description"] as? String ?? ""
//
//        if let geo = document.data()?["_geoloc"] as? Dictionary<String, Double> {
//            self.geoposition = GeoPosition(geo["lng"]!, geo["lat"]!)
//        }
        
        
        
//        images
//        self.images = document.data()?["imagesArray"] as? [String] ?? [String]()

    }
    
    
    func toProfile() -> Profile {
        var profile = Profile()
        profile["uid"] = self.uid as AnyObject
        profile["owner"] = self.uidOwner as AnyObject
        profile["name"] = self.name as AnyObject
        profile["description"] = self.description as AnyObject
        profile["images"] = self.images as AnyObject
        profile["geoposition"] = self.geoposition?.dataGeoposition() as AnyObject
        
        
        return profile
    }
    
    
    
    
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
