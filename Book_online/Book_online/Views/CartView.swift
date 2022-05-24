//
//  CartView.swift
//  Book_online
//
//  Created by diyuan on 2022/5/21.
//

import Foundation
import SwiftUI
struct CartView : View{
    @EnvironmentObject var db : DBManager
    @State private var showAlert = false
    var body: some View{
        ScrollView{
            if db.cartBooks.count > 0{
                ForEach(db.cartBooks, id: \.id){
                    book in BookRow(book: book)
                }
                HStack{
                    Text("Total:")
                    Spacer()
                    Text("\(db.total).0$")
                        .bold()
                }
                .padding()
                //Payment
                Button{
                    print("This is payment button.")
                    showAlert = true
                    //db.pay = true
                    //db.addtoOrder(books: db.cartBooks)
                }label: {
                    Text("Pay")
                        .cornerRadius(20)
                        .frame(width:160)
                        .background(Color.black.opacity(0.08))
                        .scaledToFit()
                }
                .alert(isPresented: $showAlert){
                    Alert(
                        title:Text("Really pay?"),
                        message: Text("Your cart books will be added to order."),
                        primaryButton: .default(
                            Text("Cancel")
                        ),
                        secondaryButton: .destructive(Text("Yes")){
                            db.pay = true
                            db.addtoOrder(books: db.cartBooks)
                        }
                    )
                }
            }
            else{
                Text("Your cart now is empty.")
            }
        }
        .navigationTitle(Text("Cart"))
        .padding(.top)
        //Payment
    }
}
struct CartView_Previews : PreviewProvider{
    static var previews: some View{
        CartView().environmentObject(DBManager())
    }
}
