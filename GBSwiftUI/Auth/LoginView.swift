//
//  LoginView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 21.03.2022.
//

import SwiftUI

struct LoginView: View {

    @State private var login = "admin"
    @State private var password = "123"

    @Binding var isUserLoggedIn: Bool

    @State private var showIncorrentCredentialsWarning = false

    var body: some View {
        VStack {
            Image("VKLogo")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding([.top, .bottom], 70)
            TextField("Email или телефон", text: $login)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField("Пароль", text: $password)
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
        .alert(isPresented: $showIncorrentCredentialsWarning) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text("Некорректный пароль")
                )
            }
    }

    private func logInButtonDidTap() {
        if login == "admin" && password == "123" {
            isUserLoggedIn = true
        } else {
            showIncorrentCredentialsWarning = true
        }

        password = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
    }
}
