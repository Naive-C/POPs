//
//  CreateCommunity.swift
//  POPs
//
//  Created by Naive-C on 2022/04/24.
//

import SwiftUI

struct CreateCommunity: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var createCommuVM = CommunityViewModel()
    
    @State var commuName: String = ""
    @State var description: String = ""
    @State var postImage: Image?
    @State var selectedImage: UIImage?
    @State private var image: Image?
    
    @State var imagePickerPresented = false
    
    @State var commuType: String = "Non"
    
    @Binding var rightSide: Bool
    @Binding var leftSide: Bool
    
    let tabs = ["Non","Food","Activity","Clothes"]
    
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
            
            VStack(alignment: .leading) {
            Text("Community Name")
                    .font(.system(size: 12, weight: .regular))
            CustomTextField(text: $commuName, placeholder: Text("Community Name"))
                .padding([.horizontal, .vertical], 10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            }
            
            VStack(alignment: .leading) {
            Text("Description")
                    .font(.system(size: 12, weight: .regular))
            CustomTextField(text: $description, placeholder: Text("Description"))
                .padding([.horizontal, .vertical], 10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            }
            .padding(.top, 10)
            
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab)
                        .font(.callout)
                        .foregroundColor(commuType == tab ? .white : .black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background {
                            if commuType == tab {
                                Capsule()
                                    .fill(Color("Blue"))
                            }
                        }
                        .contentShape(Capsule())
                        .onTapGesture {
                            withAnimation{commuType = tab}
                        }
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            if !commuName.isEmpty && image != nil && !description.isEmpty{
            Button(action: {
                mode.wrappedValue.dismiss()
                
                if leftSide {
                    self.leftSide.toggle()
                }
                else if rightSide {
                    self.rightSide.toggle()
                }
                if let image = selectedImage {
                    createCommuVM.createCommunity(commuName: commuName, image: image, description: description, commuType: commuType)
                }
            }, label: {
                Text("Create a community")
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
            })
            }
            else {
                Button(action: {
                    if let image = selectedImage {
                        createCommuVM.createCommunity(commuName: commuName, image: image, description: description, commuType: commuType)
                    }
                }, label: {
                    Text("Create a community")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                })
            }
            
        }
        .padding(.top, 30)
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Create a community")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                })
            }
        }
    }
}

extension CreateCommunity {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}
