//
//  RealmDatabase.swift
//  CodeChallenge
//
//  Created by mp-dev on 8/1/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabase {
    let realm = try! Realm()
    
    //Saving data into Realm Database
    func saveDataInDatabase(data:[DataModel]) {
        try! realm.write {
             realm.deleteAll()
            for singleElement in data {
                let myReal = MyRealObject()
                myReal.myStruct = singleElement
                realm.add(myReal)
            }
             
        }
    }
    
    //Fetching Data from Realm Database
    func fetchDataFromRealm() -> Results<MyRealObject> {
        let result = realm.objects(MyRealObject.self)
        
        return result
    }

}
