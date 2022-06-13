//
//  LoginView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    @Binding var switchAuth: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    AuthTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding([.horizontal, .vertical], 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    
                    AuthSecureTextField(text: $password, placeholder: Text("Password"))
                        .padding([.horizontal, .vertical], 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    
                    Spacer()
                    Button(action: {
                        loginVM.login(email: email, password: password)
                        loginVM.loginExecption.toggle()
                    }, label: {
                        Text(loginVM.loginExecption ? "" : "Continue")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: summer[0]),
                                               startPoint: .leading,
                                               
                                               endPoint: .trailing)
                            )
                            .cornerRadius(20)
                            .overlay {
                                if loginVM.loginExecption {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                }
                            }
                    })
                }
                .padding(.horizontal)
            }
            .padding(.top, 30)
            .navigationTitle("Log in")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        withAnimation {
                            self.switchAuth.toggle()
                        }
                    }, label: {
                        Text("Sign up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(switchAuth: .constant(false))
    }
}
