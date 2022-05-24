//
//  OrderRow.swift
//  Book_online
//
//  Created by diyuan on 2022/5/22.
//

import Foundation
import SwiftUI
struct OrderRow : View{
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
            Text(book.getDate())
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}
struct OrderRow_Previews:PreviewProvider{
    static var previews: some View{
        OrderRow(book: examBooks[0]).environmentObject(DBManager())
    }
}
