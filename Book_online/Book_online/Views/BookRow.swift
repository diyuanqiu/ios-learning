//
//  BookRow.swift
//  Book_online
//
//  Created by diyuan on 2022/5/21.
//

import Foundation
import SwiftUI
struct BookRow : View{
    @EnvironmentObject var db : DBManager
    var book : Books
    @State private var showDetail = false
    var body: some View{
        HStack(spacing:20){
            Image(book.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50)
                .cornerRadius(10)
                .onTapGesture {
                    showDetail = true
                }
            NavigationLink(destination: BookDetail(book: book), isActive: $showDetail){
                EmptyView()
            }.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10){
                Text(book.name)
                    .bold()
                Text(book.author)
                Text("\(book.price)$")
                
            }
            Spacer()
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.88, brightness: 0.835))
                .onTapGesture {
                    db.removefromCart(book: book)
                }
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}
struct BookRow_Previews:PreviewProvider{
    static var previews: some View{
        BookRow(book: examBooks[0]).environmentObject(DBManager())
    }
}
