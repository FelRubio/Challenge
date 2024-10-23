//
//  ProductTableViewCell.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let installmentLabel = UILabel()
    private let shippingLabel = UILabel()
    private let productImageView = UIImageView()
    private var bottomConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.numberOfLines = 2

        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        priceLabel.textColor = .black
        
        installmentLabel.font = UIFont.systemFont(ofSize: 14)
        installmentLabel.textColor = .gray
        
        shippingLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        shippingLabel.textColor = .systemGreen
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 8
        productImageView.layer.masksToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        installmentLabel.translatesAutoresizingMaskIntoConstraints = false
        shippingLabel.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(installmentLabel)
        contentView.addSubview(shippingLabel)
        contentView.addSubview(productImageView)
        
        // Set constraints
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            installmentLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            installmentLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            installmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        bottomConstraint = installmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.title
        priceLabel.text = product.price.currencyFormatted(code: product.currencyId)
        
        // Installment and shipping info
        installmentLabel.text = "\(product.installmentsData.quantity)x \(product.installmentsData.amount.currencyFormatted(code: product.currencyId))"
        
        if product.shippingData.freeShipping {
            shippingLabel.isHidden = false
            shippingLabel.text = "Free shipping!"
            
            // Remove the previous bottom constraint
            bottomConstraint?.isActive = false
            
            // Update the bottom constraint to be linked to the shipping label
            NSLayoutConstraint.activate([
                shippingLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
                shippingLabel.topAnchor.constraint(equalTo: installmentLabel.bottomAnchor, constant: 4),
                shippingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                shippingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        } else {
            shippingLabel.isHidden = true
            
            // Update the bottom constraint to be linked to the installment label
            bottomConstraint?.isActive = false
            bottomConstraint = installmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            bottomConstraint?.isActive = true
        }
        
        loadImage(from: product.thumbnailURL)
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            productImageView.image = UIImage(systemName: "photo.on.rectangle")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.productImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

