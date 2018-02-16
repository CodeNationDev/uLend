//
//  ImageCoreData.swift
//  uLendApp
//
//  Created by Manu on 16/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import UIKit

extension ImageCoreData {
    func mappedImage() -> UIImage {
        return UIImage(data: self.imageData!)!
    }
}
