//
//  DashboardViewController.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 30/08/24.
//

import UIKit

/// A view controller that manages a dashboard with a carousel, a list, and a search bar.
///
/// `DashboardViewController` sets up and manages a carousel, a list displayed in a table view, and a search bar for filtering the list. It also includes a floating action button that presents a bottom sheet when tapped.
class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    /// The collection view for displaying the carousel.
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    /// The page control for indicating the current page of the carousel.
    @IBOutlet weak var carouselPageControl: UIPageControl!
    /// The search bar for filtering the list.
    @IBOutlet weak var searchBarButton: UISearchBar!
    /// The table view for displaying the list.
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Properties
    /// The view model for managing carousel data and state.
    let viewModel = CarouselViewModel()
    /// The view model for managing list data and search functionality.
    let listViewModel = ListViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Carousel view with horizontal scrolling.
        setupCarousel()
        // Initialize the page control with the number of carousel items.
        setupPageControl()
        
        // Set delegates and data sources for table view and search bar.
        listTableView.delegate = self
        listTableView.dataSource = self
        searchBarButton.delegate = self
        
        // Register custom cells for the table view and collection view.
        let nib = UINib(nibName: "ListViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "ListViewCell")
        let carouselCellNib = UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
        carouselCollectionView.register(carouselCellNib, forCellWithReuseIdentifier: "carouselCell")
        
        // Add the floating action button to the view.
        addFloatingActionButton()
        
        // Reload the table view data to reflect initial state.
        listTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update the carousel layout to match the current view dimensions.
        updateCarouselLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Invalidate the layout of the collection view to ensure correct layout updates.
        carouselCollectionView.collectionViewLayout.invalidateLayout()
        // Force the table view to layout its subviews and recalculate the content size.
        listTableView.layoutIfNeeded()
        
        // Reload the table view data asynchronously to reflect any changes.
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    // MARK: - Setup Methods
    
    /// Configures the carousel collection view with the necessary layout and delegate settings.
    private func setupCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.collectionViewLayout = layout
        carouselCollectionView.isPagingEnabled = true
    }
    
    /// Updates the layout of the carousel collection view to ensure items fit the view's dimensions.
    private func updateCarouselLayout() {
        guard let layout = carouselCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // Adjust the item size to match the carouselCollectionView's width
        let itemWidth = carouselCollectionView.frame.width
        let itemHeight = carouselCollectionView.frame.height
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.invalidateLayout() // This forces the layout to update
    }
    
    /// Sets up the page control for the carousel.
    func setupPageControl() {
        carouselPageControl.numberOfPages = viewModel.items.count
        carouselPageControl.currentPage = viewModel.currentIndex
    }
    
    /// Updates the page control to reflect the current page of the carousel.
    func updatePageControl() {
        carouselPageControl.currentPage = viewModel.currentIndex
    }
    
    /// Adds a floating action button to the view.
    private func addFloatingActionButton() {
        let buttonSize: CGFloat = 60
        let floatingButton = FloatingActionButton(frame: CGRect(x: view.frame.width - buttonSize - 16, y: view.frame.height - buttonSize - 32, width: buttonSize, height: buttonSize))
        
        // Add an action to the button
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        
        // Add the button to the view hierarchy
        self.view.addSubview(floatingButton)
        
        // Set constraints to keep the button in the bottom-right corner
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            floatingButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButton.widthAnchor.constraint(equalToConstant: buttonSize),
            floatingButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    /// Handles the floating action button tap event.
    @objc private func floatingButtonTapped() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.modalTransitionStyle = .coverVertical
        
        // Present the bottom sheet
        present(bottomSheetVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

/// Extension to handle data source and delegate methods for the carousel collection view.
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// Returns the number of items in the collection view.
    /// - Parameters:
    ///   - collectionView: The collection view requesting this information.
    ///   - section: The section in which the items are displayed.
    /// - Returns: The number of items in the section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    /// Configures and provides a cell for the collection view at the specified index path.
    /// - Parameters:
    ///   - collectionView: The collection view requesting the cell.
    ///   - indexPath: The index path of the cell to provide.
    /// - Returns: A configured collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CarouselCollectionViewCell
        let imageName = viewModel.items[indexPath.item].imageName
        cell.configure(with: imageName)
        return cell
    }
    
    /// Updates the page control when the user scrolls the carousel and the scrolling has stopped.
    /// - Parameter scrollView: The scroll view that finished scrolling.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewModel.currentIndex = pageIndex
        updatePageControl()
    }
    
    /// Updates the page control when the user scrolls the carousel and the scrolling animation ends.
    /// - Parameter scrollView: The scroll view that finished scrolling animation.
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewModel.currentIndex = pageIndex
        updatePageControl()
    }
}

// MARK: - UITableViewDataSource

/// Extension to handle data source methods for the list table view.
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Returns the number of rows in the table view for the specified section.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The section in which the rows are displayed.
    /// - Returns: The number of rows in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.filteredItems.count
    }
    
    /// Configures and provides a cell for the table view at the specified index path.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path of the cell to provide.
    /// - Returns: A configured table view cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else {
            return UITableViewCell()
        }
        
        let item = listViewModel.filteredItems[indexPath.row]
        
        // Use the configure method to set up the cell
        cell.configure(title: item.title, subTitle: item.subTitle, imageName: item.imageName)
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension DashboardViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the search text in the view model
        listViewModel.searchText = searchText
        
        // Reload the table view to reflect the filtered data
        listTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard when the search button is clicked
    }
}

