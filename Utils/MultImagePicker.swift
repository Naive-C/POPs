////
////  MultImagePicker.swift
////  POPs
////
////  Created by Naive-C on 2022/05/04.
////
//
////MARK: PHPicker Ref https://www.youtube.com/watch?v=uARkVheOqSg&ab_channel=Kavsoft
//
//import PhotosUI
//import SwiftUI
//
//struct ImagePickerM: UIViewControllerRepresentable {
//    func makeCoordinator() -> Coordinator {
//        return ImagePickerM.Coordinator(parent1: self)
//    }
//    
//    @Binding var images: [UIImage]
//    @Binding var picker: Bool
//    
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        
//        config.filter = .images
//        config.selectionLimit = 0
//        
//        let picker = PHPickerViewController(configuration: config)
//        
//        picker.delegate = context.coordinator
//        
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//        
//    }
//    
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: ImagePickerM
//        
//        init(parent1: ImagePickerM) {
//            parent = parent1
//        }
//        
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            
//            parent.picker.toggle()
//            
//            for img in results {
//                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
//                        guard let image1 = image else {
//                            print(err)
//                            return
//                        }
//                        
//                        self.parent.images.append(image as! UIImage)
//                    }
//                }
//                else {
//                    
//                }
//            }
//        }
//    }
//}
