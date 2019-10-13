//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/28.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit


class ViewController: BaseViewController {

    struct CellItem {
        let title: String
        let vcClass: UIViewController.Type
    }
    
    var dataSource = [CellItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RxSwift"
        
        setupViews()
        setupDataSource()
    }

    private func setupViews() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.hiddenEmptyCells()
        view.addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    private func setupDataSource() {
        dataSource = [
            CellItem(title: "RxSwift初体验", vcClass: RxSwiftTestViewController.self),
            CellItem(title: "Login", vcClass: LoginViewController.self),
            CellItem(title: "Register", vcClass: RegisterViewController.self),
            CellItem(title: "Calculator", vcClass: CalculatorViewController.self),
            CellItem(title: "Combine", vcClass: CombineViewController.self)
        ];
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        
        let vcClass = dataSource[indexPath.row].vcClass
        let nextVC = vcClass.init()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
