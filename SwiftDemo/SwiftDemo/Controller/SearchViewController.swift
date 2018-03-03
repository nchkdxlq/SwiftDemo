//
//  SearchViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/11/26.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class SearchViewController: BaseTableViewController {

    private var search: LQSearch!
    private var rearchResult = SearchResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true

        search = LQSearch(controller: rearchResult)
        search.delegate = rearchResult
        rearchResult.testNav = navigationController
        view.addSubview(tableView)
        tableView.tableHeaderView = search.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
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


extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = "text: \(indexPath.row)"
        return cell
    }
    
    
}

