//
//  NSData+text.swift
//  SlipboxApp
//
//  Created by a.menshikov on 30.06.2021.
//

import Foundation

extension NSData {
    func toAttributedString() -> NSAttributedString {
        let data = Data(referencing: self)
        let options:  [NSAttributedString.DocumentReadingOptionKey : Any] = [.documentType: NSAttributedString.DocumentType.rtfd, .characterEncoding: String.Encoding.utf8]
        
        let result = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        
        return result ?? NSAttributedString(string: "")
    }
}

extension NSAttributedString {
    func toNSData() -> NSData? {
        let options:  [NSAttributedString.DocumentAttributeKey : Any] = [.documentType: NSAttributedString.DocumentType.rtfd, .characterEncoding: String.Encoding.utf8]
        let range = NSRange(location: 0, length: length)

        guard let result = try? data(from: range, documentAttributes: options) else {
            return nil
        }

        return NSData(data: result)
    }
}
