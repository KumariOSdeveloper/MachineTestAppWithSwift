//
//  ListModel.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 30/08/24.
//

import Foundation

/// A model representing an item in the list.

/// This struct holds the information necessary for each list item, such as the title, description, and image name.
struct ListItem: Identifiable {
    let id = UUID() // Unique identifier for each item
    let title: String // The title of the item
    let subTitle: String // A brief description of the item
    let imageName: String // The name of the image asset associated with the item
}
