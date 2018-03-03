//
//  LQSearch.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/11/24.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import Foundation
import UIKit

protocol SearchProtocol: class {
    func updateSearchResults(search: LQSearch, keyWord: String?)
    func didClickedSearch(search: LQSearch, keyWord: String?)
}

extension SearchProtocol {
    func didClickedSearch(search: LQSearch, keyWord: String?) {}
}

class LQSearch: NSObject {
    
    private(set) var controller: UIViewController!
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    private(set) var searchController: UISearchController!
    private(set) var defaultView: UIView!
    weak var delegate: SearchProtocol?
    
    convenience init(controller: UIViewController) {
        self.init()
        self.controller = controller
        
        searchController = UISearchController(searchResultsController: controller)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchBar.delegate = self
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.orange
        searchBar.backgroundColor = UIColor.red
        
        defaultView = UIView(frame: searchController.view.bounds)
        defaultView.backgroundColor = UIColor.clear
        searchController.view.addSubview(defaultView)
        let icon = UIImageView()
        icon.image = UIImage(named: "Me")
        icon.bounds.size = CGSize(width: 100, height: 100)
        defaultView.addSubview(icon)
        icon.center = defaultView.center
        
    }
    
    private override init() { }
    
}



//MARK: - UISearchBarDelegate
extension LQSearch: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        defaultView.isHidden = !searchText.isEmpty
        print(searchText)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didClickedSearch(search: self, keyWord: searchBar.text)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(#function)
    }
}



//MARK: -

extension LQSearch: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function)
    }
    
    
    // if implement this method, above methods will not call
//    func presentSearchController(_ searchController: UISearchController) {
//        
//    }
}

//MARK: - UISearchResultsUpdating

extension LQSearch: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        delegate?.updateSearchResults(search: self, keyWord: searchBar.text)
    }
}







