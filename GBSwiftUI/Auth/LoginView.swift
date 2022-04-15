//
//  LoginView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 21.03.2022.
//

//import SwiftUI
//
//struct LoginView: View {
//
//    @State private var login = "admin"
//    @State private var password = "123"
//
//    @Binding var isUserLoggedIn: Bool
//
//    @State private var showIncorrentCredentialsWarning = false
//
//    var body: some View {
//        VStack {
//            Image("VKLogo")
//                .resizable()
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//                .padding([.top, .bottom], 70)
//            TextField("Email или телефон", text: $login)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
//            SecureField("Пароль", text: $password)
//                .padding(.bottom, 10)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            Button(action: logInButtonDidTap, label: {
//                Spacer()
//                Text("Войти")
//                    .fontWeight(.semibold)
//                Spacer()
//            })
//            .padding(.all, 12)
//            .foregroundColor(.white)
//            .background(Color.blue)
//            .cornerRadius(10)
//            .disabled(login.isEmpty || password.isEmpty)
//            Spacer()
//        }
//        .padding()
//        .alert(isPresented: $showIncorrentCredentialsWarning) {
//                Alert(
//                    title: Text("Ошибка"),
//                    message: Text("Некорректный пароль")
//                )
//            }
//    }
//
//    private func logInButtonDidTap() {
//        if login == "admin" && password == "123" {
//            isUserLoggedIn = true
//        } else {
//            showIncorrentCredentialsWarning = true
//        }
//
//        password = ""
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(isUserLoggedIn: .constant(false))
//    }
//}

import SwiftUI
import WebKit

struct LoginView: UIViewRepresentable {
    
//    @Binding var isUserLoggedIn: Bool
    
    fileprivate let navigationDelegate = WebViewNavigationDelegate()//(viewModel: LoginViewModel())
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = buildAuthRequest() {
            uiView.load(request)
        }
    }
    
    private func buildAuthRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "8122760"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "friends,photos,wall,groups,offline"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        return components.url.map { URLRequest(url: $0) }
    }
    
    private func buildAuthRequestw() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "yandex.ru"
        
        return components.url.map { URLRequest(url: $0) }
    }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString)
        else {
            decisionHandler(.allow)
            return
        }
        
        print("TOKEN = ", token as Any)
        print("userId = ", userIdString as Any)
        UserDefaults.standard.set(token, forKey: "vkToken")
        UserDefaults.standard.set(userIdString, forKey: "userId")
        NotificationCenter.default.post(name: NSNotification.Name("vkTokenSaved"), object: self)
        
        decisionHandler(.cancel)
    }
}
