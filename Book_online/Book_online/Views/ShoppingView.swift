//
//  ShoppingView.swift
//  Book_online
//
//  Created by diyuan on 2022/5/20.
//

import Foundation
import SwiftUI
struct ShoppingView : View{
    @EnvironmentObject var db : DBManager
    var body: some View{
        TabView{
            BookView()
                .tabItem{
                    Image(systemName: "book")
                    Text("Book")
                }
            OrderView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Order")
                }
        }
    }
}
struct ShoppingView_Previews:PreviewProvider{
    static var previews: some View{
        ShoppingView().environmentObject(DBManager())
    }
}
