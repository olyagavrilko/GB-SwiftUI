//
//  ContentView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 21.03.2022.
//

import SwiftUI

struct ContentView: View {

    @State private var login = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Image("VKLogo")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding([.top, .bottom], 70)
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .padding(.bottom, 10)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: logInButtonDidTap, label: {
                Spacer()
                Text("Войти")
                    .fontWeight(.semibold)
                Spacer()
            })
            .padding(.all, 12)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .disabled(login.isEmpty || password.isEmpty)
            Spacer()
        }
        .padding()
    }

    private func logInButtonDidTap() {
        print("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
