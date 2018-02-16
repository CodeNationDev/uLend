//
//  Service_LocalCoreData.swift
//  uLendApp
//
//  Created by Manu on 15/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import CoreData


class Service_LocalCoreData {
    
    let stack = CoreDataStack.sharedInstance
    
    func itemsStored() -> [Item]?{
        
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<ItemManaged> = ItemManaged.fetchRequest()
        
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchedItems = try context.fetch(request)
            var items = [Item]()
            for managedItem in fetchedItems {
                items.append(managedItem.mappedObject())
            }
            return items
        } catch  {
            print("malo malo malo")
            return nil
        }
    }
    

    func insertItem(_ saveItem: Item){
        
        let context = stack.persistentContainer.viewContext
        let item = ItemManaged(context: context)
        
        item.uid = saveItem.uid
        item.uidOwner = saveItem.uidOwner
        item.name = saveItem.name
        item.descripcion = saveItem.description
//        item.images = saveItem.images! as NSObject
        item.sync = true
        
        do {
            try context.save()
            print("se ha creado el item con éxito")
        } catch  {
            print("Error actualizando Core Data")
        }
        
    }
    
    
    func insertImages(_ item: Item!, _ data: Data!, _ imageUrl: String!){
        
        let context = stack.persistentContainer.viewContext
        let image = ImageCoreData(context:context)
        
        image.imageData = data
        image.uidItem = item.uid
        image.imageUrl = imageUrl
        
        
//        var arrayImageCoreData = [ImageCoreData]()
        
//        for data in images {
//            let imageCoreData = ImageCoreData(context: context)
//
//            imageCoreData.imageData = data
//            imageCoreData.imageUrl = stringImage
//            imageCoreData.uidItem = item.uid
//
//            arrayImageCoreData.append(imageCoreData)
//
//
//        }
        do {
            try context.save()
            print("se ha guardado la imagen con éxito")
        } catch {
            print("error actualizando Core Data")
        }
        
        
        
    }
    
    
    func removeItemByUID(_ uid: String!){
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<ItemManaged> = ItemManaged.fetchRequest()
        let predicate = NSPredicate(format: "uid = \(uid)")
        request.predicate = predicate
        
        do {
            let items = try context.fetch(request)
            if items.count > 0 {
                context.delete(items.last!)
            } else {
                return
            }
            try context.save()
        } catch {
            print("Errores, errores y más errores")
        }
        
        
        //se deberían eliminar las imágenes que tenemos en caché
        
    }
    
    
    
}
