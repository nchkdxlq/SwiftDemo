//
//  NKCollectionHeaderView.swift
//  SwiftDemo
//
//  Created by Knox on 2020/12/24.
//  Copyright © 2020 nchkdxlq. All rights reserved.
//

import UIKit

class NKCollectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        addSubview(label)
        label.text = "CollectionHeaderView"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
        
        label.backgroundColor = UIColor.green
        
        backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
