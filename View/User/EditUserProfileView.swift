//
//  EditUserProfileView.swift
//  POPs
//
//  Created by Naive-C on 2022/06/06.
//
//
import Foundation
import SwiftUI
import Kingfisher

struct EditUserProfileView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject private var viewModel: EditUserProfileViewModel
    
    @State var description: String = ""
    @State var social: String = ""
    
    @State var postImage: Image?
    @State var selectedImage: UIImage?
    @State private var image: Image?
    
    @State var imagePickerPresented = false
    
    @Binding var rightSide: Bool
    @Binding var isActive: Bool
    
    init(viewModel: EditUserProfileViewModel, rightSide: Binding<Bool>, isActive: Binding<Bool>) {
        self.viewModel = viewModel
        self._rightSide = rightSide
        self._isActive = isActive
    }
    
    var body: some View {
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
                        KFImage(URL(string: viewModel.user.profileImageUrl))
                            .resizable()
                            .frame(width: 140, height: 140)
                            .scaledToFill()
                    })
                    .cornerRadius(20)
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })
                }
            }
            .padding([.horizontal, .bottom])
            
            VStack(alignment: .leading) {
                Text("About (optional)")
                    .font(.system(size: 12, weight: .regular))
                CustomTextField(text: $description, placeholder: Text("A little description of yourself"))
                    .padding([.horizontal, .vertical], 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(2)
                
                HStack {
                    Image("Instagram-Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                    Text("Instagram (optional)")
                }
                .padding(.top)
                .font(.system(size: 12, weight: .regular))
                SocialTextField(text: $social, placeholder: Text("username"))
                    .padding([.horizontal, .vertical], 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(2)
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Edit Profile")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if let image = selectedImage {
                        viewModel.saveUserDate(description: description, image: image, social: social)
                    }
                    else {
                        viewModel.saveUserDate(description: description, social: social)
                    }
                    self.rightSide.toggle()
                    self.isActive.toggle()
                }, label: {
                    Text("Save")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color("Blue"))
                        .cornerRadius(20)
                })
            }
        }
    }
}

extension EditUserProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}
