//
//  NSPredicate+helper.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import Foundation
import CoreData

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
