//
//  BookCard.swift
//  Book_online
//
//  Created by diyuan on 2022/5/20.
//

import Foundation
import SwiftUI
struct BookCard : View{
    @EnvironmentObject var db : DBManager
    var book : Books
    @State private var showDetail = false
    var body: some View{
        ZStack(alignment: .topTrailing){
            ZStack(alignment: .bottom){
                Button{
                    showDetail = true
                }label: {
                    Image(book.image)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width:160)
                        .scaledToFit()
                }
                NavigationLink(destination: BookDetail(book: book), isActive: $showDetail){
                    EmptyView()
                }.ignoresSafeArea()
                //Image(book.image)
                //    .resizable()
                //    .cornerRadius(20)
                //    .frame(width: 160)
                //    .scaledToFit()
                VStack(alignment: .leading){
                    Text(book.name)
                        .bold()
                    Text("\(book.price)$")
                        .font(.caption)
                }
                .padding()
                .frame(width: 160, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 160, height: 180)
            .shadow(radius: 3)
            
            Button{
                db.addtoCart(book: book)
            } label: {
                Image(systemName: "plus")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}
struct BookCard_Previews:PreviewProvider{
    static var previews: some View{
        BookCard(book: examBooks[0]).environmentObject(DBManager())
    }
}
