//
//  ProductListViewController.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private var viewModel = ProductViewModel()
    private var isLoadingMore = false
    private var debounceTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        
        setupUI()
        viewModel.fetchInitialProducts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setupUI() {
        // Search Bar
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Products"
        navigationItem.titleView = searchBar
        
        // Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
    }

    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        let detailVC = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounceTimer?.invalidate()
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.viewModel.searchProducts(with: searchText) {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
