//
//  HomeTableViewCell.swift
//  CodeChallenge
//
//  Created by mp-dev on 7/31/20.
//  Copyright © 2020 shabbir. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {

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
    
    // MARK:- Initialization Method
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        
        
    }

   // MARK:- Cell setup Method
    fileprivate func setUpCellView() {
        addSubview(idLabel)
        addSubview(typeLabel)
        addSubview(dateLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(20)
                    make.top.equalToSuperview().offset(20)
                    make.width.equalToSuperview().multipliedBy(0.5)
                }

        typeLabel.snp.makeConstraints { (make) in
                   make.left.equalToSuperview().offset(20)
                   make.top.equalTo(idLabel.snp.bottom).offset(10)
                   make.width.equalTo(idLabel.snp.width)
            }

        dateLabel.snp.makeConstraints { (make) in
                    make.right.equalToSuperview().offset(-20)
                    make.top.equalToSuperview().offset(20)
                    make.width.equalTo(idLabel.snp.width)
                }
        
    }

}
