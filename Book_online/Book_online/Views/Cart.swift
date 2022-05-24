//
//  Cart.swift
//  Book_online
//
//  Created by diyuan on 2022/5/21.
//

import Foundation
import SwiftUI
struct Cart : View{
    var numberofBook : Int
    var body: some View{
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .padding(.top, 10)
            if numberofBook > 0{
                Text("\(numberofBook)")
                    .font(.caption).bold()
                    .foregroundColor(.white)
                    .frame(width:15,height: 15)
                    .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .cornerRadius(50)
            }
        }
    }
}
struct Cart_Previews:PreviewProvider{
    static var previews: some View{
        Cart(numberofBook: 1)
    }
}
