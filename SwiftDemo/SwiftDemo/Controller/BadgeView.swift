//
//  BadgeView.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/31.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

protocol BadgeViewDelegate: class {
    func badgeViewDidBlast(_ badgeView: BadgeView)
}

extension BadgeViewDelegate {
    func badgeViewDidBlast(_ badgeView: BadgeView) {}
}

class BadgeView: UIButton {
    
    private var originSuperView: UIView?
    private var originCenter: CGPoint?
    private var originCenterForDistence = CGPoint.zero
    override var center: CGPoint {
        didSet {
            if originCenter == nil {
                originCenter = center
            }
        }
    }
    
    
    var maxDistence: CGFloat = 100.0
    weak var delegate: BadgeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        setBackgroundImage(UIImage(named: "gen_badge_bg"), for: .normal)
        titleLabel?.textColor = UIColor.white
        
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(BadgeView.panHandle(_:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc private func panHandle(_ pan: UIPanGestureRecognizer) {
        guard let view = pan.view, let superView = view.superview else {  return }
        let point = pan.location(in: superView)

        view.center = point
        if pan.state == .began {
            print("began")
            originSuperView = superView
            if let window = UIApplication.shared.keyWindow {
                originCenterForDistence = window.convert(point, from: superView)
                window.addSubview(view)
                view.center = originCenterForDistence
            } else {
                view.center = point
            }
        } else if pan.state == .changed {
            print("changed")
            let distence = point.distence(from: originCenterForDistence)
            if distence > maxDistence {
                blastAnimation(completion: { 
                    self.delegate?.badgeViewDidBlast(self)
                })
            }
        } else if pan.state == .ended {
            print("ended")
            if let __originSuperView = originSuperView, let __originCenter = originCenter {
                let result = __originSuperView.convert(view.center, from: view.superview)
                __originSuperView.addSubview(view)
                view.center = result
                UIView.animate(withDuration: 0.25, delay: 0.05, usingSpringWithDamping: 0.25, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
                    view.center = __originCenter
                }, completion: { (finished) in
                    
                })
            }
        }
    }
    
    private func blastAnimation(completion: (() -> Void)?) {
        
        isHidden = true
        completion?()
    }
    
    override var isHighlighted: Bool {
        didSet {
            layer.removeAnimation(forKey: "shake")
            
            if isHighlighted {
                let shake: CGFloat = 5.0
                let keyAnim = CAKeyframeAnimation()
                keyAnim.keyPath = "transform.translation.x"
                keyAnim.values = [-shake, shake, -shake]
                keyAnim.repeatCount = Float(Int.max)
                keyAnim.duration = 0.3
                layer.add(keyAnim, forKey: "shake")
            }
        }
    }
    
    var badgeValue: String? {
        didSet {
            isHidden = badgeValue == nil
            
            let text = badgeValue ?? ""
            setTitle(badgeValue, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: text.count > 2 ? 7.5 : 10.0)
        }
    }
}
