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
    
    var refreshBlock: VoidClosure?
    
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
        let indicator = UIActivityIndicatorView(style: .gray)
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
            view.isHidden = true
        }
        
        addPullTextLabelConstraint()
        addReleaseTextLabelConstraint()
        addIndicatorViewConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPullTextLabelConstraint() {
        let centerX = NSLayoutConstraint(item: pullTextLabel, attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self, attribute: .centerX,
                                         multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: pullTextLabel, attribute: .centerY,
                                     relatedBy: .equal,
                                     toItem: self, attribute: .centerY,
                                     multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    private func addReleaseTextLabelConstraint() {
        let centerX = NSLayoutConstraint(item: releaseTextLabel, attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self, attribute: .centerX,
                                         multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: releaseTextLabel, attribute: .centerY,
                                     relatedBy: .equal,
                                     toItem: self, attribute: .centerY,
                                     multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    private func addIndicatorViewConstraint() {
        let centerX = NSLayoutConstraint(item: indicatorView, attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self, attribute: .centerX,
                                         multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: indicatorView, attribute: .centerY,
                                     relatedBy: .equal,
                                     toItem: self, attribute: .centerY,
                                     multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    
    func shouldRefreshWithDistance(distance: CGFloat,
                                   newDragging: Bool,
                                   oldDragging: Bool) -> Bool {
        if distance < bounds.height {
            pullTextLabel.isHidden = false
            releaseTextLabel.isHidden = true
        } else {
            pullTextLabel.isHidden = true
            releaseTextLabel.isHidden = false
            // dragging = false 时开始刷新
            return !newDragging && oldDragging
        }
        return false
    }
    
    func startAnimating() {
        pullTextLabel.isHidden = true
        releaseTextLabel.isHidden = true
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        pullTextLabel.isHidden = true
        releaseTextLabel.isHidden = true
        indicatorView.stopAnimating()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
