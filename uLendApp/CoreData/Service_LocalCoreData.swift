//
//  Service_LocalCoreData.swift
//  uLendApp
//
//  Created by Manu on 15/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import CoreData
import UIKit


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
    
    func imagesByUIDimage(_ uidItem: String!) -> [Data]? {
        
        var images = [Data]()
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<ImageCoreData> = ImageCoreData.fetchRequest()
        
        let predicate = NSPredicate(format: "uiditem = %@", uidItem!)
        request.predicate = predicate

        do {
            let fetchedImages = try context.fetch(request)
            for image in fetchedImages {
                images.append(image.imageData!)
                
            }
        } catch {
            return nil
        }
            return images
    }
    

    func insertItem(_ saveItem: Item){
        
        let context = stack.persistentContainer.viewContext
        let item = ItemManaged(context: context)
        
        item.uid = saveItem.uid
        item.uidOwner = saveItem.uidOwner
        item.name = saveItem.name
        item.descripcion = saveItem.description
        item.sync = true
        
        do {
            try context.save()
        } catch  {
            print("Error actualizando Core Data")
        }
    }
    

    
    
    func insertImage(_ item: Item!, _ data: Data!, _ imageUrl: String!){
        
        let context = stack.persistentContainer.viewContext
        let image = ImageCoreData(context:context)
        
        image.imageData = data
        image.uiditem = item.uid
        image.imageUrl = imageUrl

        do {
            try context.save()
        } catch {
            print("error actualizando Core Data")
        }
    }
    
    func insertImages(_ item: Item!, _ data: [Data]!, _ imageUrl: [String]?){
        let context = stack.persistentContainer.viewContext
        var images = [ImageCoreData(context:context)]
        
        for x in 0...(data.count - 1) {
            let image = ImageCoreData()
            image.imageData = data[x]
            image.uiditem = item.uid
            image.imageUrl = imageUrl?[x] ?? "sin url"
            images.append(image)
        }
        
        do {
            try context.save()
            
        } catch {
            print("error actualizando Core Data")
        }
    }
    
    func removeItem(_ item: Item!){
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<ItemManaged> = ItemManaged.fetchRequest()
        let predicate = NSPredicate(format: "uid = %@", item.uid!)
        request.predicate = predicate
        
        do {
            let _item = try context.fetch(request)
            context.delete(_item.last!)
            
            try context.save()
            print("item eliminado")
        } catch  {
            print("error eliminando el item")
        }
        
        self.removeImagesByUID(item.uid)
    
    }
    
    func removeImagesByUID(_ uid: String!){
        let context = stack.persistentContainer.viewContext
        let request : NSFetchRequest<ImageCoreData> = ImageCoreData.fetchRequest()
        let predicate = NSPredicate(format: "uiditem = %@", uid)
        request.predicate = predicate
        
        do {
            let images = try context.fetch(request)
            for image in images {
                context.delete(image)
            }
            try context.save()
            
        } catch  {
            print("no ha eliminado las fotos")
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
