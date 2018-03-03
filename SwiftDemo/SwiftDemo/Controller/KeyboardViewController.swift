//
//  KeyboardViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/25.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class SectionDataSource<T> {
    
    var indentifier: String = ""
    var headerTitle: String?
    var footerTitle: String?
    
    var dataList: [T]
    var dataCount: Int {
        return dataList.count
    }
    
    init(_ dataList: [T] = []) {
        self.dataList = dataList
    }
    
    func data(at index: Int) -> T {
        return dataList[index]
    }
}



class KeyboardViewController: EZBaseVC {
    
    fileprivate var textFiled: UITextField!
    fileprivate var tableView: UITableView!
    fileprivate var dataSource = [SectionDataSource<Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numStrArr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        let alphaArr = ["A", "B", "C", "D", "E"]
        
        let section0: SectionDataSource<Any> = SectionDataSource(numStrArr)
        let section1: SectionDataSource<Any> = SectionDataSource(alphaArr)
        dataSource.append(section0)
        dataSource.append(section1)
        
        setupSubViews()
        addObserver()
        
    }
    
    
    private func setupSubViews() {
        let height: CGFloat = 50.0
        
        let tableRect = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height-height)
        tableView = UITableView(frame: tableRect, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hiddenEmptyCells()
        tableView.showsHorizontalScrollIndicator = false
//        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.allowsSelection = false
        tableView.rowHeight = 50.0
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIndentifier)
        
        let rect = CGRect(x: 0, y: UIScreen.height - height, width: UIScreen.width, height: height)
        textFiled = UITextField(frame: rect)
        view.addSubview(textFiled)
        textFiled.borderStyle = .roundedRect
        textFiled.delegate = self
    }
    
    private func addObserver() {
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(KeyboardViewController.keyBoardHandle(_:)),
                           name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    fileprivate func sendMessage() {
        let text = textFiled.text ?? ""
        textFiled.text = nil
        if text.length == 0 { return }
        let section = 1
        let sectionData = dataSource[section]
        sectionData.dataList.append(text)
        let indexPath = IndexPath(row: sectionData.dataCount-1, section: section)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .bottom)
        tableView.endUpdates()
        scrollToBottom()
    }
    
    fileprivate func scrollToBottom() {
        DispatchQueue.main.async {
            let contentSize = self.tableView.contentSize
            let size = self.tableView.bounds.size
            if contentSize.height > size.height {
                self.tableView.setContentOffset(CGPoint(x: 0, y: contentSize.height-size.height), animated: true)
            }
        }
    }
    
    
    @objc private func keyBoardHandle(_ note: Notification) {

        print("-------------------------------------")
        guard let userInfo = note.userInfo else { return }
        
        print(userInfo)
        
        guard let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let endFrame = value.cgRectValue
        let deltaY = endFrame.height
        
        if endFrame.minY < UIScreen.height { // 显示

            UIView.animate(withDuration: 0.25, animations: {
                self.textFiled.transform = CGAffineTransform(translationX: 0, y: -deltaY)
            })
        } else {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.textFiled.transform = CGAffineTransform.identity
            })
        }
    }
    
}

//MARK: UITableViewDelegate
extension KeyboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let top = UITableViewRowAction(style: .normal, title: "置顶") { (action, indexPath) in
            
            let sectionData = self.dataSource[indexPath.section]
            let data = sectionData.dataList.remove(at: indexPath.row)
            let firstSection = self.dataSource.first!
            firstSection.dataList.insert(data, at: 0)
            tableView.updateCells {
                tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            }
            tableView.setEditing(false, animated: false)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            let sectionData = self.dataSource[indexPath.section]
            sectionData.dataList.remove(at: indexPath.row)
            tableView.updateCells {
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
        
        return  [delete, top]
    }
    
}

//MARK: UITableViewDataSource
extension KeyboardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIndentifier)!
    
        let sectionData = dataSource[indexPath.section]

        cell.textLabel?.text = sectionData.data(at: indexPath.row) as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

//MARK: UITextFieldDelegate
extension KeyboardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            sendMessage()
            return false
        } else {
            return true
        }
    }
}

extension KeyboardViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if textFiled.isFirstResponder {
            textFiled.resignFirstResponder()
        }
    }
}


