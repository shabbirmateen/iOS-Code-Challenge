//
//  DataModel.swift
//  CodeChallenge
//
//  Created by mp-dev on 8/1/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import Foundation
import RealmSwift


struct DataModel:Codable {
    var id:String?
    var type:String?
    var date:String?
    var data:String?
    
    init(id:String,type:String,date:String,data:String) {
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
}


class MyRealObject : Object {

@objc private dynamic var structData:Data? = nil

var myStruct : DataModel? {
    get {
        if let data = structData {
            return try? JSONDecoder().decode(DataModel.self, from: data)
        }
        return nil
    }
    set {
        structData = try? JSONEncoder().encode(newValue)
    }
  }
}
