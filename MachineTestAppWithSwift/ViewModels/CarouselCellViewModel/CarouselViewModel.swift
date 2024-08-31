//
//  CarouselViewModel.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 30/08/24.
//

import Foundation

/// The view model for the carousel view.
///
/// `CarouselViewModel` manages the state of the carousel, including the current index and the list of carousel items. It provides the necessary data to the view and handles any related logic.
class CarouselViewModel: ObservableObject {
    @Published var currentIndex = 0 // The index of the currently visible carousel item
    
    /// The list of items to be displayed in the carousel.
    let items: [CarouselItem] = [
        CarouselItem(imageName: "image1"),
        CarouselItem(imageName: "image2"),
        CarouselItem(imageName: "image3"),
        CarouselItem(imageName: "image4"),
        CarouselItem(imageName: "image5")
    ]

    /// Computed property that provides the list of image names from the items.
    var images: [String] {
        items.map { $0.imageName }
    }
}
