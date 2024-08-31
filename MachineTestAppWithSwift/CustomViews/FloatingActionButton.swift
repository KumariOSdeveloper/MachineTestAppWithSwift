//
//  FloatingActionButton.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 30/08/24.
//

import Foundation
import UIKit

/// A custom UIButton subclass representing a floating action button (FAB) with a three-dot icon.
class FloatingActionButton: UIButton {
    
    // MARK: - Initialization
    
    /// Initializes the button with a frame.
    ///
    /// - Parameter frame: The frame for the button.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    /// Initializes the button from a storyboard or XIB file.
    ///
    /// - Parameter coder: The coder used to decode the button's properties.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Private Methods
    
    /// Configures the appearance and layout of the button.
    private func setupButton() {
        // Set the button's appearance
        self.backgroundColor = .blue
        self.layer.cornerRadius = self.frame.size.width / 2
        
        // Create the 3 vertical dots icon
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        
        // Add three dots to the stack view
        for _ in 0..<3 {
            let dot = UIView()
            dot.backgroundColor = .white
            dot.layer.cornerRadius = 4
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: 8).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 8).isActive = true
            stackView.addArrangedSubview(dot)
        }
        
        // Add the stack view to the button and center it
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // Add shadow to the button
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
    }
}
