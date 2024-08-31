//
//  BottomSheetViewController.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 31/08/24.
//

import UIKit

/// A view controller that presents a bottom sheet with statistics about a list of items.
///
/// `BottomSheetViewController` displays the count of items and the top characters with their frequencies in a bottom sheet.
class BottomSheetViewController: UIViewController {

    // MARK: - Properties

    /// The view model that provides statistics data.
    private let viewModel = StatisticsViewModel()

    /// A label that displays the total count of items in the list.
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "List 1 (4 items)"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    /// A label that serves as a header for the top characters section.
    private let topCharactersLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Characters:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    /// A stack view that displays the top characters with their counts.
    private let characterCountsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    /// A label that serves as a header for the list of items.
    private let itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "Items:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    /// A stack view that displays all items in the selected list.
    private let itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    /// A button that allows selecting different lists.
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select List", for: .normal)
        button.addTarget(self, action: #selector(showListSelection), for: .touchUpInside)
        return button
    }()

    /// A button that allows navigating back.
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        return button
    }()

    // MARK: - View Lifecycle

    /// Called after the view has been loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.selectList("List 1") // Set the initial list and calculate statistics
        updateUI()
    }

    // MARK: - Private Methods

    /// Sets up the view's appearance and layout constraints.
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10

        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(topCharactersLabel)
        view.addSubview(characterCountsStackView)
        view.addSubview(itemsLabel)
        view.addSubview(itemsStackView)
        view.addSubview(listButton) // Add the list button

        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topCharactersLabel.translatesAutoresizingMaskIntoConstraints = false
        characterCountsStackView.translatesAutoresizingMaskIntoConstraints = false
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false
        listButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            topCharactersLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            topCharactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topCharactersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            characterCountsStackView.topAnchor.constraint(equalTo: topCharactersLabel.bottomAnchor, constant: 10),
            characterCountsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterCountsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            itemsLabel.topAnchor.constraint(equalTo: characterCountsStackView.bottomAnchor, constant: 20),
            itemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            itemsStackView.topAnchor.constraint(equalTo: itemsLabel.bottomAnchor, constant: 10),
            itemsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            listButton.topAnchor.constraint(equalTo: itemsStackView.bottomAnchor, constant: 20),
            listButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    /// Updates the UI with the latest data from the view model.
    private func updateUI() {
        // Update title with the name of the selected list and item count
        let itemCount = viewModel.items.count
        titleLabel.text = "\(viewModel.selectedList) (\(itemCount) items)"
        
        // Clear existing arranged subviews
        characterCountsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add updated character count labels
        for (character, count) in viewModel.topCharacters {
            let label = UILabel()
            label.text = "\(character) = \(count)"
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            characterCountsStackView.addArrangedSubview(label)
        }

        // Add updated item labels
        for item in viewModel.items {
            let label = UILabel()
            label.text = item
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            itemsStackView.addArrangedSubview(label)
        }
    }

    /// Shows an alert for selecting a list.
    @objc private func showListSelection() {
        let alertController = UIAlertController(title: "Select List", message: nil, preferredStyle: .actionSheet)
        
        for listName in viewModel.lists.keys {
            let action = UIAlertAction(title: listName, style: .default) { [weak self] _ in
                self?.viewModel.selectList(listName)
                self?.updateUI()
            }
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }

    /// Dismisses the bottom sheet view controller.
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
