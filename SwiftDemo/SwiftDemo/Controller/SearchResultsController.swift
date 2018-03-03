//
//  SearchResultsController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/11/26.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class SearchResultsController: BaseTableViewController {

    
    var testNav: UINavigationController?
    
    fileprivate var allData = [String]()
    fileprivate var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.bottom
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableHeaderView = UIView()
        
        for _ in 0...100 {
            let text = "number: \(arc4random() % 100)\(arc4random() % 200)"
            allData.append(text)
        }
    }

    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        
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

extension SearchResultsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let nav = presentingViewController?.navigationController
        nav?.pushViewController(TestViewController(), animated: true)
    }
}


extension SearchResultsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "firend\(section)"
    }
    
}


extension SearchResultsController: SearchProtocol {
    
    func updateSearchResults(search: LQSearch, keyWord: String?) {
        dataSource.removeAll()
        if let key = keyWord {
            allData.forEach({ (item) in
                if item.contains(key) {
                    dataSource.append(item)
                }
            })
        }
        
        tableView.reloadData()
    }
}
