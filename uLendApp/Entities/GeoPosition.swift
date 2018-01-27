//
//  GeoPosition.swift
//  uLendApp
//
//  Created by Manu on 22/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation


struct GeoPosition {
    
    var long : Double!
    var lat : Double!
    
    init(_ long: Double, _ lat: Double) {
        self.long = long
        self.lat = lat
    }
    
    func dataGeoposition() -> Dictionary<String, Double> {
        return ["lng":self.long, "lat":self.lat]
    }
    
}
