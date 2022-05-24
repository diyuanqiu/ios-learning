//
//  BookDetail.swift
//  Book_online
//
//  Created by diyuan on 2022/5/21.
//

import Foundation
import SwiftUI
struct BookDetail :View{
    @EnvironmentObject var db : DBManager
    var book : Books
    var body: some View{
        VStack(){
            Image(book.image)
                .resizable()
                .cornerRadius(10)
                .frame(width: 250, height: 250)
                .scaledToFit()
            List{
                Section(header: Text("Info")){
                    Text("Name: \(book.name)")
                    Text("Author: \(book.author)")
                    Text("Description: \(book.description)")
                    Text("Type: \(book.type)")
                    Text("Price: \(book.price)$")
                }
            }
        }
    }
}
struct BookDetail_Previews:PreviewProvider{
    static var previews: some View{
        BookDetail(book: examBooks[0]).environmentObject(DBManager())
    }
}
