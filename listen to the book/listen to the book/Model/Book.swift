//
//  Book.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/16/22.
//

import Foundation

class Book{
    let name: String
    let url: URL
    var page:Int = 0
    var rate:Float = 0.0
    
    init(name: String,url: URL){
        self.name = name
        self.url = url
    }
    
    static var currentReadingBook:Book = Book.shared[0]
    
    static let shared:[Book] = [Book(name: "IEEE", url: Bundle.main.url(forResource: "IEEE", withExtension: "pdf")!),Book(name: "ordinary", url: Bundle.main.url(forResource: "ordinary", withExtension: "pdf")!)]
    
}

