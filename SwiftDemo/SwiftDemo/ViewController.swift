//
//  ViewController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/3.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit
import SnapKit

private let cellTitle = "cellTitle"
private let cellNextVC = "cellNextVC"

class ViewController: EZBaseVC {
    
    struct CellInfo {
        var title: String?
        var vcClass: UIViewController.Type?
    }
    
    var dataSource = [CellInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift learning"
        let frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        let tableView = UITableView(frame: frame, style: .plain)
        view.addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(r: 215, g: 215, b: 215)

        tableView.addPullRefresh {
            let time = DispatchTime.now() + 2.0
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                tableView.refreshHeader?.endRefresh()
            })
        }
        

        setCellItems()
    }
    
    func setCellItems()
    {
        let item0 = CellInfo(title: "Grammar", vcClass: GrammarViewController.self)
        dataSource.append(item0)
        
        let item1 = CellInfo(title: "TestView", vcClass: TestViewController.self)
        dataSource.append(item1)
        
        let item2 = CellInfo(title: "searchControler", vcClass: SearchViewController.self)
        dataSource.append(item2)
        
        let item3 = CellInfo(title: "SwiftyJSON", vcClass: SwiftyJSONViewController.self)
        dataSource.append(item3)
        
        let item4 = CellInfo(title: "UIButton", vcClass: ButtonViewController.self)
        dataSource.append(item4)
        
        let item5 = CellInfo(title: "AudioPlayer", vcClass: AudioViewController.self)
        dataSource.append(item5)
        
        let item6 = CellInfo(title: "keyboard", vcClass: KeyboardViewController.self)
        dataSource.append(item6)
        
        let item7 = CellInfo(title: "Gesture", vcClass: GestureRecognizerViewController.self)
        dataSource.append(item7)
        
        let item8 = CellInfo(title: "RichText", vcClass: RichTextViewController.self)
        dataSource.append(item8)
        
        let item9 = CellInfo(title: "Kingfisher", vcClass: KingfisherViewController.self)
        dataSource.append(item9)
        
        let item10 = CellInfo(title: "Protocol", vcClass: ProtocolViewController.self)
        dataSource.append(item10)
        
        let item11 = CellInfo(title: "Video", vcClass: VideoPlayViewController.self)
        dataSource.append(item11)
        
        let item12 = CellInfo(title: "WKWebView", vcClass: WKWebViewController.self)
        dataSource.append(item12)
        
        let item13 = CellInfo(title: "UIStackView", vcClass: StackViewController.self)
        dataSource.append(item13)
        
        let item14 = CellInfo(title: "Misc", vcClass: MiscViewController.self)
        dataSource.append(item14)
        
        let item15 = CellInfo(title: "URLSession", vcClass: URLSessionViewController.self)
        dataSource.append(item15)
        
        let item16 = CellInfo(title: "UICollectionView", vcClass: CollectionViewController.self)
        dataSource.append(item16)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIndentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseIndentifier)
            cell?.textLabel?.textColor = UIColor.RGB(74, 74, 74)
        }
        cell!.textLabel?.text = dataSource[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        
        if let vcClass = dataSource[indexPath.row].vcClass {
            let nextVC = vcClass.init()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}

extension ViewController: BadgeViewDelegate {
    func badgeViewDidBlast(_ badgeView: BadgeView) {
        print(#function)
    }
}


extension ViewController: UIScrollViewDelegate {

    
    
}




