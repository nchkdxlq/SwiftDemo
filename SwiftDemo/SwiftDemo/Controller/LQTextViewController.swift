//
//  LQTextViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 16/9/18.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class LQTextViewController: NSObject {

    var textView: UITextView?
    var textViewDelegate: UITextViewDelegate?
    
    init(textView: UITextView) {
        super.init()
        self.textView = textView
        textView.delegate = self
    }
    
}

// MARK: - UITextViewDelegate

extension LQTextViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let delegate = self.textViewDelegate else {
            return
        }
        if delegate.responds(to: #selector(textViewDidBeginEditing(_:))) {
            delegate.textViewDidBeginEditing!(textView)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return true
    }
}

// MARK: - UIScrollViewDelegate

extension LQTextViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


