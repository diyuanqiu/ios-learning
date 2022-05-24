//
//  Books.swift
//  Book_online
//
//  Created by diyuan on 2022/5/19.
//

import Foundation
struct Books : Identifiable{
    var id = UUID()
    var name : String
    var image : String
    var author : String
    var price : Int64
    var description : String
    var type : String
    
    func getDate()->String{
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let date = format.string(from: Date())
        return date
    }
}
    var examBooks = [Books(name: "Test", image: "book1", author: "Diyuan", price: 32, description: "Test", type: "test")]
