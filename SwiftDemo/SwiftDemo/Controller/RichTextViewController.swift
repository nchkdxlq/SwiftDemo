//
//  RichTextViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2017/1/2.
//  Copyright © 2017年 nchkdxlq. All rights reserved.
//

import UIKit
import SnapKit



class RichTextData {
    
    private(set) var size = CGSize.zero
    
    private(set) var attributeText: NSAttributedString?
    
    var data = [Any]()
    
    func caculateAttributeText() {
        let attrText = NSMutableAttributedString()
        data.forEach { (item) in
            if attrText.length > 0 {
                attrText.append(NSAttributedString.newLineText())
            }
            if let image = item as? UIImage {
                
                let attachment = NSTextAttachment()
                attachment.image = image
                let width = image.size.width > (UIScreen.width - 50) ? 300 : image.size.width
                let height = width * image.size.height / image.size.width
                attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
                let attamentText = NSAttributedString(attachment: attachment)
                let __testAttamentText = NSMutableAttributedString(attributedString: attamentText)
                attrText.append(attamentText)
            } else if item is String {

//                let str = item as! String
//                let attr: [String: Any] = [NSForegroundColorAttributeName.rawValue: UIColor.black,
//                                           NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
//                let strAttr = NSAttributedString(string: str, attributes: attr)
//                attrText.append(strAttr)
            }
        }
        
        let maxSize = CGSize(width: UIScreen.width - 20, height: CGFloat(MAXFLOAT))
        var size = attrText.boundingSize(with: maxSize)
        size.height += 40
        self.size = size
        
        attributeText = attrText
    }
}


////////////////////////////////////////////////////////////////////////////////////



class RichTextViewController: EZBaseVC {

    
    var tableView: UITableView!
    var dataSource = [RichTextData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.hiddenEmptyCells()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RichTextCell.self,
                           forCellReuseIdentifier: RichTextCell.reuseIndentifier)
        
        let text1 = "在 Cocoa 的模型-视图-控制器 (Model-view-controller)架构里，控制器负责让视图和模型同步。这一共有两步：当 model 对象改变的时候，视图应该随之改变以反映模型的变化；当用户和控制器交互的时候，模型也应该做出相应的改变"
        let text2 = "会在运行 -setLComponent: 中的代码之前以及之后被自动调用。如果我们写了 -setLComponent: 或者我们选择使用自动 synthesize 的 lComponent 的 accessor 到时候就会发生这样的事情。"
        let image1 = UIImage(named: "girl_3")!
    
        for _ in 0..<10 {
            let cellData = RichTextData()
            cellData.data.append(text1)
            cellData.data.append(image1)
            cellData.data.append(text2)
            cellData.caculateAttributeText()
            dataSource.append(cellData)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RichTextViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = dataSource[indexPath.row]
        return data.size.height
    }
}


extension RichTextViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RichTextCell.reuseIndentifier) as! RichTextCell
        cell.selectionStyle = .none
        let data = dataSource[indexPath.row]
//        cell.richTextView.attributedText = data.attributeText
        cell.richTextLabel.attributedText = data.attributeText
        return cell
    }
}



