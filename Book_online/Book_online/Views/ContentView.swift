//
//  ContentView.swift
//  Book_online
//
//  Created by diyuan on 2022/5/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var db = DBManager.share
    @State private var username = ""
    @State private var usercode = ""
    @State private var wrongUsername : Float = 0
    @State private var wrongUsercode : Float = 0
    @State private var showLogin = false
    var body: some View {
        NavigationView{
            VStack{
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Account",text: $username)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(10)
                    .border(.red,width: CGFloat(wrongUsername))
                SecureField("Password",text: $usercode)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(10)
                    .border(.red,width: CGFloat(wrongUsercode))
                    .padding(.bottom)
                Button("Sign in"){
                    checkUser(username: username, usercode: usercode)
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 30)
                .background(Color.blue)
                .cornerRadius(5)
                .padding(.bottom)
                Button("Sign up"){
                    db.addUser(name: username, code: usercode)
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 30)
                .background(Color.blue)
                .cornerRadius(5)
                NavigationLink(destination: ShoppingView(), isActive: $showLogin ){
                    EmptyView()
                }
            }
        }.navigationBarHidden(true)
    }
    func checkUser(username: String, usercode: String){
        let success = db.getUser(name: username, code: usercode)
        if(success){
            wrongUsername = 0
            wrongUsercode = 0
            showLogin = true
        }
        else{
            wrongUsername = 2
            wrongUsercode = 2
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
