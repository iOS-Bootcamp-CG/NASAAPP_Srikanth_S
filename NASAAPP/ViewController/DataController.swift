//
//  datacontroller.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 20/01/23.
//

import Foundation
import CoreData

class Datacontroller : ObservableObject{
    
    //creating instannce of nspersistentcontainer for nasa data model
    let container = NSPersistentContainer(name: "Nasa")
    init(){
        //This method loads the persistent stores
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("failed to load data \(error.localizedDescription)")
                
            }}
    }
    //saves changes happened in persistant store
    func Save(context:NSManagedObjectContext){
        do{
            try context.save()
            print("data saved")
        } catch{
            print("we could not save")
        }
        
    }
    //adds data to entity
    func addData(title: String,img:String,image:Data,imgdesc:String,imgdate:String,context:NSManagedObjectContext){
        let nasa=Nasa(context: context)
        nasa.imgid=UUID()
        nasa.title=title
        nasa.imageurl=img
        nasa.imgdesc=imgdesc
        nasa.image=image
        nasa.imgdate=imgdate
        Save(context: context)
        
    }
    
    
}
