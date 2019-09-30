//
//  RichTextCell.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2017/1/2.
//  Copyright © 2017年 nchkdxlq. All rights reserved.
//

import UIKit

class RichTextCell: UITableViewCell {
    
    var richTextView: UITextView!
    var richTextLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        richTextView = UITextView()
//        richTextView.isEditable = false
//        richTextView.delegate = self
//        contentView.addSubview(richTextView)
//        richTextView.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsetsMake(10, 10, 10, 10))
//        }
        
        richTextLabel = UILabel()
        richTextLabel.numberOfLines = 0
        contentView.addSubview(richTextLabel)
        richTextLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RichTextCell: UITextViewDelegate {
    
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        print(#function)
        return false
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        
        print(#function)
        return true
    }
}
