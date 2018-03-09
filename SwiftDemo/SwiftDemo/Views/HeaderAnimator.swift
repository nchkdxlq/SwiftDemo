//
//  HeaderAnimator.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/7.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

class HeaderAnimator: UIView {
    
    var trigger: CGFloat = 40.0
    let pullTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        label.text = "下拉刷新..."
        
        return label
    }()
    
    let releaseTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        label.text = "释放刷新"
        return label
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let views: [UIView] = [pullTextLabel, releaseTextLabel, indicatorView]
        views.forEach { (view) in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(pullTextLabel)
        addSubview(releaseTextLabel)
        addSubview(indicatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dragDistanceDidChanged(distance: CGFloat) {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
