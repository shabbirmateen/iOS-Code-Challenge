//
//  ApiManager.swift
//  CodeChallenge
//
//  Created by mp-dev on 8/1/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import Foundation
import SystemConfiguration

protocol ResponseDataDelegate:NSObject {
    func getApiResponse(data:[DataModel])
}


class ApiManager {
    
   weak var responseDelegate:ResponseDataDelegate?
    
    //MARK:- Api call Method
    func fetchData(urlString:String) {
        let request = URLRequest(url: URL(string: urlString)!)

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
              
                if let error = error {
                    print(error.localizedDescription)
                }
                                              
                if let data = data {
                    self.savefileDataOnDisk(jsonData: data)
                let readData = self.readDataFromDisk()
                                               
                    Parser().parse(jsonData: readData!) { (data) in
                        let sortArray = data.sorted { (s1, s2) -> Bool in
                            
                            return (s1.type ?? "") > (s2.type ?? "")
                        }
                        self.responseDelegate?.getApiResponse(data: sortArray)
                    }
            }
            
        }).resume()
        
    }
    
    //Saving json file in documentDirectory
    func savefileDataOnDisk(jsonData: Data) {
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("data.json")
            try jsonData.write(to: fileURL, options: .atomic)
        } catch { }
    }

    //Read json file from documentDirectory
    func readDataFromDisk() -> Data? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("data.json").path
        if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath) {
            return data
        }
        return nil
    }
    
    //Check device is connected to the network
    func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)

            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)

        }
    
}


