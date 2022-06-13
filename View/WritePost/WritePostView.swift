//
//  WritePostView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/12.
//

import SwiftUI
import UIKit
import MapKit
import Firebase
import Kingfisher

struct WritePostView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var uploadVM = UploadPostViewModel()
    
    @State var title: String = ""
    @State var bodyText : String = ""
    @State var postImage: Image?
    @State var selectedImage: UIImage?
    
    @State var imagePickerPresented = false
    
    // MARK: SelectCommunityPresented
    @State private var isPresented: Bool = false
    
    @State private var isSelected: Bool = false
    @State private var stored: Bool = false
    
    @State private var isActive: Bool = false
    
    @State var latitude: CLLocationDegrees = .init()
    @State var longitude: CLLocationDegrees = .init()
    @State var address0: String = ""
    @State var address1: String = ""
    
    @State var commu: CommunityModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Spacer().fullScreenCover(isPresented: $isPresented, content: {
                    SelectCommunityView(isSelected: $isSelected, stored: $stored, commuStore: $commu)
                })
                
                VStack {
                    VStack(alignment: .leading) {
                        if isSelected || stored {
                            Button(action: {
                                self.isPresented.toggle()
                            }, label: {
                                HStack {
                                    KFImage(URL(string: commu.communityProfileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                    
                                    Text(commu.communityName)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.black)
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                            })
                            Divider()
                        }
                        else {
                            VStack {
                                Text("")
                                    .padding(.bottom, 20)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            TitleTextField(text: $title, placeholder: Text("Add a title"))
                                .background(.clear)
                            Divider()
                            NavigationLink(
                                destination: MapView(latitude: $latitude, longitude: $longitude, address0: $address0, address1: $address1, isActive: $isActive)
                                    .navigationBarHidden(true)
                                , isActive: $isActive
                                , label: {
                                    if address0.isEmpty {
                                        if !address1.isEmpty {
                                            Text(address1)
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, weight: .regular))
                                                .padding(.horizontal, 3)
                                        }
                                        else {
                                            Text("Add location")
                                                .foregroundColor(.black.opacity(0.5))
                                                .font(.system(size: 18, weight: .regular))
                                                .padding(.horizontal, 3)
                                        }
                                    }
                                    else {
                                        Text(address0)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .regular))
                                            .padding(.horizontal, 3)
                                    }
                                })
                            Divider()
                            TextArea(text: $bodyText, placeholder: "Add a body")
                                .background(.clear)
                            
                            
                            VStack(alignment: .leading) {
                                if postImage == nil {
                                    Button(action: {
                                        imagePickerPresented.toggle()
                                    }, label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .scaledToFill()
                                            .font(.system(size: 14, weight: .light))
                                            .frame(width: 40, height: 40)
                                    })
                                    .frame(width: getRect().width - 80, height: 300)
                                    .frame(maxWidth: .infinity, maxHeight: 440, alignment: .center)
                                    .background(Rectangle()
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])))
                                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                                        ImagePicker(image: $selectedImage)
                                    })
                                }
                                else {
                                    if let image = postImage {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: getRect().width - 40, maxHeight: 440, alignment: .center)
                                            .clipShape(Rectangle())
                                            .cornerRadius(20)
                                            .overlay(alignment: .topTrailing) {
                                                Button(action: {
                                                    postImage = nil
                                                }, label: {
                                                    Image(systemName: "xmark")
                                                        .frame(width: 25, height: 25)
                                                        .foregroundColor(.white)
                                                        .background(Color.black.opacity(0.6))
                                                })
                                            }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        })
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if isSelected || stored {
                            Button(action: {
                                if let image = selectedImage {
                                    uploadVM.uploadPost(commu: commu, title: title, body: bodyText, image: image, latitude: latitude, longitude: longitude, addr: address1)
                                }
                                mode.wrappedValue.dismiss()
                            }, label: {
                                Text("Post")
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(title.isEmpty || postImage == nil ? .gray : .white)
                                    .background(Color(title.isEmpty || postImage == nil ? .systemGray6 : .systemBlue))
                                    .cornerRadius(10)
                            })
                            .disabled(title.isEmpty || postImage == nil ? true : false)
                        }
                        else {
                            Button(action: {
                                self.isPresented.toggle()
                            }, label: {
                                Text("Post")
                                    .font(.system(size: 14, weight: .bold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(title.isEmpty || postImage == nil ? .gray : .white)
                                    .background(Color(title.isEmpty || postImage == nil ? .systemGray6 : .systemBlue))
                                    .cornerRadius(10)
                            })
                        }
                    }
                }
            }
        }
    }
}

extension WritePostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
