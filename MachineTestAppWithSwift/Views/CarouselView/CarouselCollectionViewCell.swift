//
//  CarouselCollectionViewCell.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 31/08/24.
//

import UIKit

/// A collection view cell used in a carousel for displaying images.
///
/// `CarouselCollectionViewCell` represents a single cell in a collection view carousel that displays an image with rounded corners.
class CarouselCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    /// An image view that displays the image for the carousel item.
    @IBOutlet weak var carouselImage: UIImageView!

    // MARK: - Methods

    /// Configures the cell with the specified image name.
    ///
    /// - Parameter imageName: The name of the image to be displayed in the image view.
    func configure(with imageName: String) {
        // Set the image for the image view
        carouselImage.image = UIImage(named: imageName)
        
        // Apply a corner radius to the image view
        carouselImage.layer.cornerRadius = 8 // Set your desired corner radius
        carouselImage.clipsToBounds = true    // Ensure the image is clipped to the bounds
    }
}

