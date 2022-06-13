//
//  MapAnnotation.swift
//  POPs
//
//  Created by Naive-C on 2022/06/01.
//

import Foundation
import SwiftUI
import Kingfisher
import MapKit
import Combine

struct MapAnnotationView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var coordVM = PostViewModel()
    @ObservedObject var locationManager: LocationManager = .init()
    
    @State private var isPresented: Bool = false
    
    let post: PostModel
    
    init(post: PostModel) {
        self.post = post
        self.locationManager.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.post.latitude, longitude: self.post.longitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: coordVM.sortedPosts) { annotation in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)) {
                    KFImage(URL(string: annotation.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
            }
            .ignoresSafeArea()
        }
    }
}
