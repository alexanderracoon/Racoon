//
//  NSPredicate+Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 20.04.2026.
//

import Foundation

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
