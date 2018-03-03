//
//  BaseTableViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/11/26.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class BaseTableViewController: EZBaseVC {

    var tableViewStyle: UITableViewStyle = .plain
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds, style: self.tableViewStyle)
        table.backgroundColor = UIColor.clear
        table.tableFooterView = UIView()
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
