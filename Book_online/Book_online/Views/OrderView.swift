//
//  OrderView.swift
//  Book_online
//
//  Created by diyuan on 2022/5/21.
//

import Foundation
import SwiftUI
struct OrderView : View{
    @StateObject var db = DBManager.share
    var body: some View{
        ScrollView{
            if db.orderBooks.count > 0{
                ForEach(db.orderBooks, id: \.id){
                    book in OrderRow(book: book)
                }
                HStack{
                    Text("Total:")
                    Spacer()
                    Text("\(db.orderTotal).0$")
                        .bold()
                }
                .padding()
            }
            else{
                Text("Your order now is empty.")
            }
        }
        //.navigationTitle(Text("Order"))
        //.padding(.top)
    }
}
struct OrderView_Previews : PreviewProvider{
    static var previews: some View{
        OrderView().environmentObject(DBManager())
    }
}
