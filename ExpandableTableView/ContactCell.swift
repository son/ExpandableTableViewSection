//
//  ContactCell.swift
//  ExpandableTableView
//
//  Created by Takeru Sato on 2018/12/30.
//  Copyright © 2018 son. All rights reserved.
//

import UIKit

final class ContactCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        addConstraint()
    }

    private func setupSubview() {
        
    }
    
    private func addConstraint() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


