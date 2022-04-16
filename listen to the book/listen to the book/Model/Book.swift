//
//  Book.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/16/22.
//

import Foundation

struct Book{
    let name: String
    let url: URL
    var page:Int = 0
    var rate:Float = 0.0
    
    static var currentReadingBook:Book = Book.shared[0]
    
    static let shared:[Book] = [Book(name: "IEEE Article", url: Bundle.main.url(forResource: "IEEE", withExtension: "pdf")!),Book(name: "平凡的世界", url: Bundle.main.url(forResource: "ordinary", withExtension: "pdf")!)]
    
}

