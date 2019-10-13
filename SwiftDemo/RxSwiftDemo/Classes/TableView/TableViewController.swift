//
//  TableViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RxTableView"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // 动态的数据源如何处理？？？
        let items = Observable.just( (0...20).map { $0.description } )
        
        items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) {
            (row, element, cell) in
            cell.textLabel?.text = "\(element) @ row \(row)"
        }.disposed(by: disposeBag)
        
        // 选中哪一个数据源
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { print($0) } )
            .disposed(by: disposeBag)
        
        // 选中具体行
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath)
                self?.tableView.deselectRow(at: indexPath, animated: false)
            }).disposed(by: disposeBag)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
