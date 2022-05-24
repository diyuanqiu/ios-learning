//
//  BookView.swift
//  Book_online
//
//  Created by diyuan on 2022/5/20.
//

import Foundation
import SwiftUI
struct BookView : View{
    @StateObject var db = DBManager.share
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    var body : some View{
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20){
                    Section(header: Text("Mystery").frame(width: 350, height:20).background(Color.black.opacity(0.08))){
                    ForEach(db.getTypeBooks(type: "mystery"),id: \.id){
                                book in BookCard(book: book)
                                    .environmentObject(db)
                            }
                    }
                    Section(header: Text("Romantic").frame(width: 350, height:20).background(Color.black.opacity(0.08))){
                    ForEach(db.getTypeBooks(type: "romantic"),id: \.id){
                                book in BookCard(book: book)
                                    .environmentObject(db)
                            }
                    }
                    Section(header: Text("Magic").frame(width: 350, height:20).background(Color.black.opacity(0.08))){
                    ForEach(db.getTypeBooks(type: "magic"),id: \.id){
                                book in BookCard(book: book)
                                    .environmentObject(db)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Book")
            .toolbar{
                NavigationLink{
                    CartView().environmentObject(db)
                } label: {
                    Cart(numberofBook: db.cartBooks.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea()
    }
}

struct BookView_Previews : PreviewProvider{
    static var previews: some View{
        BookView().environmentObject(DBManager())
    }
}
