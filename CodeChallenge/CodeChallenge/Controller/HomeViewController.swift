//
//  HomeViewController.swift
//  CodeChallenge
//
//  Created by mp-dev on 7/30/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: UIViewController,ResponseDataDelegate {
    
    let tableView = UITableView()
    var dataArray = [DataModel]()
    let realmDataObj = RealmDatabase()
    var realmDataArray:Results<MyRealObject>?
    
    //MARK:- ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.backgroundColor = .white
        self.setTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let apiManager = ApiManager()
         apiManager.responseDelegate = self
         if apiManager.isConnectedToNetwork() == true {
           apiManager.fetchData(urlString: Constants.baseUrl)
         }else {
            realmDataArray = realmDataObj.fetchDataFromRealm()
            tableView.reloadData()
         }
         
    }
    
    // MARK:- Private Method
    
    fileprivate func setTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.homeCellIdentifier)
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    // MARK:- Api Response Method
    
    func getApiResponse(data: [DataModel]) {
        if data.count > 0 {
           dataArray = data
            
            DispatchQueue.main.sync {
                realmDataObj.saveDataInDatabase(data: data)
                realmDataArray = realmDataObj.fetchDataFromRealm()
                tableView.reloadData()
            }
            
        }
        
    }
    
    
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
    // MARK:- TableView DataSource and Delegate Method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return realmDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.homeCellIdentifier, for: indexPath) as! HomeTableViewCell
        let indexData = realmDataArray?[indexPath.row].myStruct
        cell.idLabel.text = "Id: " + (indexData?.id ?? "")
        cell.typeLabel.text = "Type: " + (indexData?.type ?? "")
        cell.dateLabel.text = "Date: " + (indexData?.date ?? "")
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.passModelData = (realmDataArray?[indexPath.row])!
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
