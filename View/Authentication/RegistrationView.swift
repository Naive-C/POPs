//
//  RegistrationView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/23.
//

import Foundation
import SwiftUI
import UIKit

struct RegistrationView: View {
    @EnvironmentObject var registerVM: AuthViewModel
    @Environment(\.presentationMode) var mode
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    
    @State var imagePickerPresented = false
    @State var isValidEmail: Bool = false
    @State var isValidName: Bool = false
    
    @State var progressActive: Bool = false
    
    @Binding var switchAuth: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if let image = image {
                        Button(action: { imagePickerPresented.toggle() }, label: {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Rectangle())
                                .cornerRadius(20)
                        }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })
                    } else {
                        Button(action: { imagePickerPresented.toggle() }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFill()
                                .font(.system(size: 14, weight: .light))
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color("Blue"))
                        })
                        .frame(width: 140, height: 140)
                        .background(Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])))
                        .cornerRadius(20)
                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })
                    }
                }
                .padding([.horizontal, .bottom])
                
                VStack {
                    AuthTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding([.horizontal, .vertical], 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .onChange(of: email){ email in
                            isValidEmail = isValidEmail(testStr: email)
                        }
                        .overlay {
                            Image(systemName: isValidEmail ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .padding(.trailing, 20)
                                .frame(width: 15, height: 15)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(isValidEmail ? .blue : .red)
                        }
                    
                    AuthTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .padding([.horizontal, .vertical], 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .onChange(of: username){ name in
                            isValidName = isValidName(testStr: name)
                            
                            if isValidName {
                                registerVM.userNameDuplicateCheck(name: name)
                            }
                        }
                        .overlay {
                            if !isValidName || !registerVM.users.isEmpty {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.trailing, 20)
                                    .frame(width: 15, height: 15)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.red)
                            }
                            else {
                                Image(systemName: "checkmark.circle.fill")
                                    .padding(.trailing, 20)
                                    .frame(width: 15, height: 15)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .foregroundColor(.blue)
                            }
                        }
                    
                    AuthSecureTextField(text: $password, placeholder: Text("Password"))
                        .padding([.horizontal, .vertical], 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    Button(action: {
                        registerVM.register(email: email, username: username, password: password, image: selectedImage)
                        self.progressActive.toggle()
                    }, label: {
                        
                        Text(self.progressActive ? "" : "Continue")
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
                                if self.progressActive {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .frame(width: 10, height: 10)
                                }
                            }
                    })
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .navigationBarTitle("Sign Up")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            self.switchAuth.toggle()
                        }
                    }, label: {
                        Text("Log in")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidName(testStr:String) -> Bool {
        let nameRegEx = "[A-Z0-9a-z가-힣]{2,24}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
    }
}
