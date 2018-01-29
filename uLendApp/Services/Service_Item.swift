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
    
    let servDB = Service_Database()
    
    
    func createItem(_ uidUser: String!, name: String, mediaUrl: [String]?, description: String, mediaData: Data?, completionHandlerItem: @escaping CompletionBool){
        
        //primero lo creamos en firestore
        let profile = [
            "owner": uidUser,
            "name" : name,
            "description": description,
            "createdDate": Date().timeIntervalSince1970
            ] as [String : Any]
        
        var ref: DocumentReference? = nil
        ref = servDB.collectionItems.addDocument(data: profile) { (error) in
            if error != nil {
                print("error adding document")
                completionHandlerItem(error?.localizedDescription, false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                
                // se debe añadir a algolia
                //creamos el item en local
                let item = Item()
                item.description = description
                item.name = name
                item.uid = ref?.documentID
                
                Service_Algolia().saveItem(item, { (errorAlg, content) in
                    if error != nil {
                        print(errorAlg)
                        completionHandlerItem(errorAlg, false)
                    } else {
                        print(content)
                        completionHandlerItem(nil, true)

                    }
                })
            }
        }
    }
    
    
    
    
    func searchItem(_ uid: String!, completionHandler: @escaping CompletionItem){
        
        let docRef = Service_Database().collectionItems.document(uid)
        
        docRef.getDocument { (document, error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            } else {
                //tenemos el document, creamos el item y le damo salida
                print(document?.data())   //imprimimos en pantalla
            }
        }
        
    }
    
    func searchItemsByOwner(_ uidOwner: String!, completionHandler: @escaping CompletionArrayItems){
        
        Service_Database().collectionItems.whereField("owner", isEqualTo: uidOwner).getDocuments { (query, error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            }
            
            
            //sin error tenemos los documents
            for quer in query!.documents {
                print("Item:")
                print(quer.data())
            }
            completionHandler(nil, nil)
        }
        
        
        
    }
    
    
    
    
}

