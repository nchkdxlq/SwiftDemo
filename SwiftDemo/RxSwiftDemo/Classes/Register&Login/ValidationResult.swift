//
//  ValidationResult.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

struct ValidationColors {
    static let okColor = UIColor.RGB(138, 221, 109)
    static let errorColor = UIColor.red
}

extension ValidationResult : CustomStringConvertible {
    var description: String {
        switch self {
        case .ok(let message):
            return message
            
        case .empty:
            return ""
            
        case .validating:
            return "validating..."
            
        case .failed(let message):
            return message
        }
    }
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .failed:
            return ValidationColors.errorColor
        default:
            return UIColor.black
        }
    }
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}


extension Reactive where Base : UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { lable, result in
            lable.text = result.description
            lable.textColor = result.textColor
        }
    }
}
