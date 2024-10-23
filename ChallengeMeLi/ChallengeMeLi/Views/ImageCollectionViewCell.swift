//
//  ImageCollectionViewCell.swift
//  ChallengeMeLi
//
//  Created by Felipe Rubio on 23/10/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let productImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(productImageView)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: URL) {
        // Download the image asynchronously and set it
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.productImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
}


class CenteredFlowLayout: UICollectionViewFlowLayout {
    let padding: CGFloat = 16

    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Centrar las celdas después del scroll
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let horizontalCenter = proposedContentOffset.x + collectionView.bounds.width / 2
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)

        guard let attributes = super.layoutAttributesForElements(in: targetRect) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        var closestAttribute: UICollectionViewLayoutAttributes?
        for attribute in attributes {
            if closestAttribute == nil {
                closestAttribute = attribute
            } else if abs(attribute.center.x - horizontalCenter) < abs(closestAttribute!.center.x - horizontalCenter) {
                closestAttribute = attribute
            }
        }

        guard let closest = closestAttribute else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        return CGPoint(x: closest.center.x - collectionView.bounds.width / 2, y: proposedContentOffset.y)
    }

    // Invalidate el layout para recalcular el scroll mientras se mueve
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
