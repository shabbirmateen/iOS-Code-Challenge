//
//  DetailViewController.swift
//  CodeChallenge
//
//  Created by mp-dev on 8/1/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class DetailViewController: UIViewController {

    var passModelData = MyRealObject()
    let webView = WKWebView()
    let textView = UITextView()
    let idLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    let typeLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    let dateLabel:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    //MARK:- ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail View"
        self.view.backgroundColor = .white
        
        self.setUpView()
    }
    
    // MARK:- UI Setup Method
    
   fileprivate func setUpView() {
        self.view.addSubview(idLabel)
        self.view.addSubview(typeLabel)
        self.view.addSubview(dateLabel)
        var bottom = textView.snp.bottom
        if passModelData.myStruct?.type == "image" {
            webView.isHidden = false
            textView.isHidden = true
            self.view.addSubview(webView)
            webView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalToSuperview().offset(60)
                make.height.equalToSuperview().multipliedBy(0.4)
            }
            bottom = webView.snp.bottom
            let link = URL(string:passModelData.myStruct?.data ?? "")
            let request = URLRequest(url: link!)
            webView.load(request)
            
        }else {
              webView.isHidden = true
              textView.isHidden = false
            self.view.addSubview(textView)
              textView.snp.makeConstraints { (make) in
                  make.left.equalToSuperview().offset(20)
                  make.right.equalToSuperview().offset(-20)
                  make.top.equalToSuperview().offset(60)
                  make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
        
        idLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(bottom).offset(20)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(idLabel.snp.width)
            make.top.equalTo(idLabel.snp.bottom).offset(20)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(bottom).offset(20)
        }
        
        
        textView.text = (passModelData.myStruct?.data ?? "")
        idLabel.text = "Id: " + (passModelData.myStruct?.id ?? "")
        typeLabel.text = "Type: " + (passModelData.myStruct?.type ?? "")
        dateLabel.text = "Date: " + (passModelData.myStruct?.date ?? "")
    }

}
