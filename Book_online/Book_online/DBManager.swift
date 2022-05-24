//
//  DBManager.swift
//  Book_online
//
//  Created by diyuan on 2022/5/19.
//

import Foundation
import SQLite
import SwiftUI
let id_column = Expression<Int64>("id")
let name_column = Expression<String>("name")
let code_column = Expression<String>("code")
let image_column = Expression<String>("image")
let author_column = Expression<String>("author")
let price_column = Expression<Int64>("price")
let decription_column = Expression<String>("decription")
let type_column = Expression<String>("type")
let bookId_column = Expression<UUID>("bookId")
class DBManager : ObservableObject{
    
    static let share = DBManager()
    private var db : Connection!
    private var userTable : Table!
    private var bookTable : Table!
    private var cartTable : Table!
    private var orderTable : Table!
    @Published private(set) var total: Int64 = 0
    @Published private(set) var cartBooks:[Books] = []
    @Published private(set) var orderBooks:[Books] = []
    @Published private(set) var orderTotal: Int64 = 0
    var pay : Bool = false
    init(){
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
            //deleteAllBook()
            addBook(name: "Murder on the Orient Express", image: "book1", author: "Agatha", price: 38, decription: "This is a mystery novel.", type: "mystery")
            addBook(name: "ABC Murder", image: "book2", author: "Agatha", price: 35, decription: "This is a mystery novel.", type: "mystery")
            addBook(name:"And Then There Were None", image: "book3", author: "Agatha", price: 45, decription: "This is a mystery novel.", type: "mystery")
            addBook(name: "The Man Who Laughs", image: "book4", author: "Hugo", price: 52, decription: "This is a romantic novel.", type: "romantic")
            addBook(name: "Notre Dame de Paris", image: "book5", author: "Hugo", price: 40, decription: "This is a romantic novel.", type: "romantic")
            addBook(name: "The Wheel of Time", image: "book6", author: "Robert", price: 68, decription: "This is a magic novel.", type: "magic")
            addBook(name: "Mistborn", image: "book7", author: "Brandon", price: 65, decription: "This is a magic novel.", type: "magic")
            addBook(name: "The Lang Price Quartet", image: "book8", author: "Daniel", price: 78, decription: "This is a magic novel.", type: "magic")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func getUserTable() -> Table{
        if userTable == nil{
            userTable = Table("users")
            try! db.run(userTable.create(ifNotExists: true, block: {
                t in t.column(id_column,primaryKey: true)
                t.column(name_column,unique: true)
                t.column(code_column)
            }))
        }
        return userTable
    }
    
    public func addUser(name:String,code:String){
        do{
            let cannotAdd = getUser(name: name)
            if(cannotAdd == true){
                print("The user has already existed.")
            }
            else{
                try! db.run(getUserTable().insert(name_column<-name, code_column<-code))
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func getUser(name:String,code:String)->Bool{
        let query = getUserTable().order(id_column.desc)
        for user in try! db.prepare(query){
            if(user[name_column] == name && user[code_column] == code){
                return true;
            }
        }
        return false
    }
    
    public func getUser(name:String)->Bool{
        let query = getUserTable().order(id_column.desc)
        for user in try! db.prepare(query){
            if(user[name_column] == name){
                return true;
            }
        }
        return false
    }
    
    public func getBookTable() -> Table{
        if bookTable == nil{
            bookTable = Table("books")
            try! db.run(bookTable.create(ifNotExists: true, block: {
                t in t.column(id_column,primaryKey: true)
                t.column(name_column)
                t.column(image_column)
                t.column(author_column)
                t.column(price_column)
                t.column(decription_column)
                t.column(type_column)
            }))
        }
        return bookTable
    }
    
    public func addBook(name:String, image:String, author:String, price:Int64, decription:String, type:String){
        do{
            let cannotAdd = getBook(name: name, image: image, author: author, price: price)
            if(cannotAdd == true){
                print("The book has already added.")
            }
            else{
                try! db.run(getBookTable().insert(name_column<-name, image_column<-image, author_column<-author, price_column<-price, decription_column<-decription, type_column<-type))
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func getBook(name:String, image:String, author:String, price:Int64)->Bool{
        let query = getBookTable().order(id_column.desc)
        for book in try! db.prepare(query){
            if(book[name_column] == name && book[image_column] == image && book[author_column] == author && book[price_column] == price){
                return true
            }
        }
        return false
    }
    
    public func getBooks()->[Books]{
        var allBooks : [Books] = []
        allBooks.removeAll()
        let query = getBookTable().order(id_column.desc)
        do{
            for books in try! db.prepare(query){
                let allBook : Books = Books(name: books[name_column], image: books[image_column], author: books[author_column], price: books[price_column], description: books[decription_column], type: books[type_column])
                allBooks.append(allBook)
            }
        }
        catch{
            print(error.localizedDescription)
        }
        return allBooks
    }
    
    public func getTypeBooks(type:String)->[Books]{
        var typeBooks : [Books] = []
        let query = getBookTable().order(id_column.desc).filter(type_column == type)
        do{
            for books in try! db.prepare(query){
                let typeBook : Books = Books(name: books[name_column], image: books[image_column], author: books[author_column], price: books[price_column], description: books[decription_column], type: type)
                typeBooks.append(typeBook)
            }
        }
        return typeBooks
    }
    
    public func deleteAllBook(){
        do{
            let query = getBookTable().delete()
            try! db.run(query)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func getCartTable() -> Table{
        if cartTable == nil{
            cartTable = Table("carts")
            try! db.run(cartTable.create(ifNotExists: true, block: {
                t in t.column(id_column,primaryKey: true)
                t.column(bookId_column)
            }))
        }
        return cartTable
    }
    
    public func addtoCart(book: Books){
        do{
            try! db.run(getCartTable().insert(bookId_column <- book.id))
            cartBooks.append(book)
            total += book.price
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func removefromCart(book: Books){
        do{
            let query = getCartTable().filter(bookId_column == book.id).delete()
            try! db.run(query)
            cartBooks = cartBooks.filter{$0.id != book.id}
            total -= book.price
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func getOrderTable() -> Table{
        if orderTable == nil{
            orderTable = Table("orders")
            try! db.run(orderTable.create(ifNotExists: true, block: {
                t in t.column(id_column,primaryKey: true)
                t.column(bookId_column)
            }))
        }
        return orderTable
    }
    
    public func addtoOrder(books: [Books]){
        do{
            for book in books{
                let query = getOrderTable().insert(bookId_column<-book.id)
                try! db.run(query)
                orderBooks.append(book)
                orderTotal += book.price
            }
            payment()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    public func payment(){
        if pay {
            cartBooks = []
            total = 0
        }
    }
}
