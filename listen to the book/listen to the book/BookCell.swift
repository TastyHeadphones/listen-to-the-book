//
//  BookCell.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/17/22.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    var book:Book?
    
    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {
            // Ignore attempts to set
        }
    }
    
    override var accessibilityLabel: String? {
        get {
            return book!.name
        }
    set {
            // Ignore attempts to set
        }
    }
    
    override var accessibilityValue: String?{
        get {
            return "has read page in\(book!.page)"
        }
    set {
            // Ignore attempts to set
        }
    }
}
