//
//  Parser.swift
//  CodeChallenge
//
//  Created by mp-dev on 8/1/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import Foundation

class Parser {
    //MARK:- Parser Method
    // Converting Json Data to custom model
    func parse(jsonData: Data,completion:@escaping ([DataModel])-> Void ){
        do {
            let decodedData = try JSONDecoder().decode([DataModel].self,
                                                       from: jsonData)
            
           
            completion(decodedData)
            
        } catch {
            print("decode error")
        }
    }
}
