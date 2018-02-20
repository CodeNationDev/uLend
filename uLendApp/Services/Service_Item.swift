//
//  Service_Item.swift
//  uLendApp
//
//  Created by Manu on 22/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase


struct Service_Item {
    
    private let servDBitems = Service_Database().collectionItems
    
    func createItem(_ uidUser: String!, name: String, mediaUrl: [String]?, description: String?, mediaData: [Data]!, completionHandlerItem: @escaping CompletionItem){
        
        //primero lo creamos en firestore
        let profile: Profile = [
            "owner": uidUser,
            "name" : name,
            "description": description ?? "",
            "createdDate": Date().timeIntervalSince1970
            ]
        
        var ref: DocumentReference? = nil
        ref = servDBitems.addDocument(data: profile) { (error) in
            if error != nil {
                completionHandlerItem(error?.localizedDescription, nil)
            } else {
                
                //creamos el item en local
                let item = Item()
                item.description = description ?? ""
                item.name = name
                item.uid = ref?.documentID
                item.uidOwner = uidUser
                //guardamos el item en coredata
                Service_LocalCoreData().insertItem(item)
                
                print("tenemos \(mediaData.count) elementos")
                
                var counter = 1//;   <- C moment?
                var counterImage = 1
                for data in mediaData {
                    
                    let imageName = "image\(counterImage).jpg"
                    counterImage += 1
                    
                    Service_Storage().itemImagesRef.child((ref?.documentID)!).child(imageName).putData(data, metadata: nil, completion: { (object, error) in
                        if let error = (error as NSError?){
                            print(error.localizedDescription)
                        } else {
                            
                            Service_LocalCoreData().insertImage(item, data, String(describing: object!.downloadURL()!))
                            
                            self.servDBitems.document(ref!.documentID).collection("mediaUrl").document("image\(counter)").setData(["mediaUrl":String(describing: object!.downloadURL()!)])
                            if counter == mediaData.count {
                                Service_Algolia().saveItem(item, { (errorAlg, content) in
                                    if error != nil {
                                        completionHandlerItem(errorAlg, item)
                                    } else {
                                        completionHandlerItem(nil, item)
                                    }
                                })
                            }
                            counter += 1
                        }
                    })
                }
            }
        }
    }
    
    
    func deleteItem(_ item: Item, completionHandler: @escaping CompletionBool){
        
        if item.uidOwner == Auth.auth().currentUser?.uid {
            servDBitems.document(item.uid!).delete(completion: { (error) in
                if let error = (error as NSError?){
                    completionHandler(error.localizedDescription, false)
                } else {
                    let collection = self.servDBitems.document(item.uid!).collection("mediaUrl").parent
                    collection?.delete()
                   
                    completionHandler(nil, true)
                }
            })
        } else {
            completionHandler("not owner",false)
        }
        
        
        
    }
    
    
    
    func updateAllProfile(_ item: Item!, completionHandler: @escaping CompletionBool){
        servDBitems.document(item.uid!).setData(item.toProfile()) { (error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
            
        }
    }
    
    func updateLabelbyUidItem(_ uidItem: String!, _ label: String, _ data: AnyHashable, completionHandler: @escaping CompletionBool){
        let profile = [label:data]
        
        
        servDBitems.document(uidItem).updateData(profile) { (error) in
            if error != nil {
                    completionHandler(error?.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
        }

    }
    
    
    
    
    /// Búsqueda de un ítem por su uid
    ///
    /// - Parameters:
    ///   - uid: uid del item
    ///   - completionHandler: error? o Item?
    func searchItem(_ uid: String!, completionHandler: @escaping CompletionItem){
        
        let docRef = Service_Database().collectionItems.document(uid)

        docRef.getDocument { (document, error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            } else {
                let item = Item(document: document)
                completionHandler(nil, item)
            }
        }
        
    }
    
    
    
    
    
    
    
    /// Items de un usuario
    ///
    /// - Parameters:
    ///   - uidOwner: uid del usuario
    ///   - completionHandler: error? o Array de Items?
    func searchItemsByOwner(_ uidOwner: String!, completionHandler: @escaping CompletionArrayItems){
        
        servDBitems.whereField("owner", isEqualTo: uidOwner).getDocuments { (documents, error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            }

            var items = [Item]()
            
            for document in documents!.documents {
                items.append(Item(document: document))
            }

            completionHandler(nil, items)
        }
        
    }
    
    
    
    
}

