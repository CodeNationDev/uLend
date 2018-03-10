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
    var imagesArray: [UIImage]?
    
    
    var country: String?
    private var loaned: Bool?
    
    
    init(){}
    
    init(_ uid: String!, _ uidOwner: String!, _ name: String!, _ description: String?){
        self.uid = uid
        self.uidOwner = uidOwner
        self.name = name
        self.description = description ?? ""
        self.loaned = false
//        self.images = images ?? [String]()
//        self.geoposition = geoposition ?? nil
    }
     
    init(document: DocumentSnapshot!){

        self.uid = document.documentID
        self.uidOwner = document.get("uidOwner") as? String
        self.name = document.get("name") as? String
        self.description = document.get("description") as? String ?? ""
        self.loaned = document.get("loaned") as? Bool ?? false
        
        if let geo = document.get("_geoloc") as? Dictionary<String, Double> {
            self.geoposition = GeoPosition(geo["lng"]!, geo["lat"]!)
        }


    }
    
    func changeLoanedToFalse(){
        ULServ_Item().updateLabelbyUidItem(self.uid!, "loaned", false) { (error, bool) in
            if let error = error {
                print(error)
            } else {
                self.loaned = false
            }
        }
    }
    
    func changeLoanedToTrue(){
        ULServ_Item().updateLabelbyUidItem(self.uid, "loaned", true) { (error, bool) in
            if let error = error {
                print(error)
            }
            else {
                self.loaned = true
            }
        }
    }
    
    func isLoaned() -> Bool {
        return self.loaned!
    }
    
    
    func imagesToItem(_ arrayData: [Data]!) {
        var array = [UIImage]()
        
        for _data in arrayData {
            guard let image = UIImage(data: _data) else {
                return
            }
            array.append(image)
        }
        
        self.imagesArray = array
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
