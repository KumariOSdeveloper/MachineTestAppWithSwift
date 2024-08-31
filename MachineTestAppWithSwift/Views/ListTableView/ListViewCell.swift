//
//  ListViewCell.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 31/08/24.
//

import UIKit

/// A table view cell used to display a list item with an image, title, and subtitle.
///
/// `ListViewCell` represents a single cell in a table view that displays an image, a title, and a subtitle.
/// The cell is configured to disable selection style.
class ListViewCell: UITableViewCell {
    // MARK: - Outlets

    /// An image view for displaying the image associated with the list item.
    @IBOutlet weak var listImageView: UIImageView!
    /// A label for displaying the title text of the list item.
    @IBOutlet weak var listTitleLabel: UILabel!
    /// A label for displaying the subtitle text of the list item.
    @IBOutlet weak var listSubTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
            super.awakeFromNib()
            // Disable the selection style to indicate that the cell is not selectable
            self.selectionStyle = .none
        }

        // MARK: - Methods

        /// Configures the cell with the given data.
        ///
        /// - Parameters:
        ///   - title: The title text for the cell.
        ///   - subTitle: The subtitle text for the cell.
        ///   - imageName: The name of the image asset to be displayed in the cell.
        func configure(title: String, subTitle: String, imageName: String) {
            // Set the title label's text
            listTitleLabel.text = title
            // Set the subtitle label's text
            listSubTitleLabel.text = subTitle
            // Set the image view's image from the given image name
            listImageView.image = UIImage(named: imageName)
            // Apply a corner radius to the image view
            listImageView.layer.cornerRadius = 8 // Set your desired corner radius
            listImageView.clipsToBounds = true    // Ensure the image is clipped to the bounds
        }
}
