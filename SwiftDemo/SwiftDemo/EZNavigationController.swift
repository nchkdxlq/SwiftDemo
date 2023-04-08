//
//  EZNavigationController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 4/28/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit

class EZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EZNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true
        }
        return viewControllers.count > 1
    }
    
}


extension EZNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return EZAnimationController(operation)
    }
    
}

class EZAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let operation: UINavigationController.Operation
    
    init(_ operation: UINavigationController.Operation) {
        self.operation = operation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let fromView = transitionContext.view(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let fromViewStartFrame = transitionContext.initialFrame(for: fromViewController)
        let toViewEndFrame = transitionContext.finalFrame(for: toViewController)
        
        var fromViewEndFrame = fromViewStartFrame
        var toViewStartFrame = toViewEndFrame
        
        // 2
        if operation == .push {
            toViewStartFrame.origin.y -= toViewEndFrame.size.height
        } else if operation == .pop {
            fromViewEndFrame.origin.y -= fromViewStartFrame.size.height
            containerView.sendSubviewToBack(toView)
        }
        
        fromView.frame = fromViewStartFrame
        toView.frame = toViewStartFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromView.frame = fromViewEndFrame
            toView.frame = toViewEndFrame
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
 }
