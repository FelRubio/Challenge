//
//  ProductDetailViewController.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import UIKit

class ProductDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var product: Product
    var viewModel: ProductDetailViewModel
    
    // UI Components
    private let scrollView = UIScrollView()
    private let imageViewCollection: UICollectionView
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()

    init(product: Product, viewModel: ProductDetailViewModel = ProductDetailViewModel()) {
        self.product = product
        self.viewModel = viewModel

        let layout = CenteredFlowLayout()
        
        let cellWidth = UIScreen.main.bounds.width - (2 * layout.padding)
        layout.itemSize = CGSize(width: cellWidth, height: 400)
        
        imageViewCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageViewCollection.isPagingEnabled = false
        imageViewCollection.showsHorizontalScrollIndicator = false
        imageViewCollection.contentInset = UIEdgeInsets(top: 0, left: layout.padding, bottom: 0, right: layout.padding)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGroupedBackground
        title = "Product details"
        
        imageViewCollection.dataSource = self
        imageViewCollection.delegate = self
        
        imageViewCollection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")

        setupUI()
        fetchProductDetails()
    }

    private func setupUI() {
        // Configuración de la interfaz de usuario
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        priceLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        nameLabel.text = product.title
        priceLabel.text = product.price.currencyFormatted(code: product.currencyId)
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(imageViewCollection)
        view.addSubview(scrollView)
        
        setupConstraints()
    }

    private func setupConstraints() {
        let padding: CGFloat = 16

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewCollection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            imageViewCollection.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            imageViewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewCollection.heightAnchor.constraint(equalToConstant: 400),  // Altura fija de 400 (ajustable)
            
            descriptionLabel.topAnchor.constraint(equalTo: imageViewCollection.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
    }

    private func fetchProductDetails() {
        viewModel.fetchProductDetail(for: product.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productDetail):
                    self?.updateUI(with: productDetail)
                case .failure(let error):
                    print("Error fetching product details: \(error)")
                }
            }
        }
    }

    private func updateUI(with productDetail: ProductDetail) {
        descriptionLabel.text = productDetail.description
        imageViewCollection.reloadData()
    }

    // UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productDetail?.pictures.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        if let imageUrl = viewModel.productDetail?.pictures[indexPath.row] {
            cell.configure(with: imageUrl)
        }
        return cell
    }
}
