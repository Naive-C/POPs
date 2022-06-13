//
//  EditCommunityView.swift
//  POPs
//
//  Created by Naive-C on 2022/06/06.
//

import Foundation
import SwiftUI
import Kingfisher

struct EditCommunityProfileView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject private var viewModel: EditCommunityProfileViewModel
    
    @State var description: String = ""
    
    @State var postImage: Image?
    @State var selectedImage: UIImage?
    @State private var image: Image?
    
    @State var imagePickerPresented = false
    
    @Binding var leftSide: Bool
    @Binding var isActive: Bool
    
    init(viewModel: EditCommunityProfileViewModel, leftSide: Binding<Bool>, isActive: Binding<Bool>) {
        self.viewModel = viewModel
        self._leftSide = leftSide
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
                        KFImage(URL(string: viewModel.commu.communityProfileImageUrl))
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
                CustomTextField(text: $description, placeholder: Text("A little description of community"))
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
                        viewModel.saveCommuDate(description: description, image: image)
                    }
                    else {
                        viewModel.saveCommuData(description: description)
                    }
                    self.leftSide.toggle()
                    self.isActive.toggle()
                    print(self.leftSide)
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

extension EditCommunityProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}
