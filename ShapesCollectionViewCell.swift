//
//  ShapesCollectionViewCell.swift
//  CollectionViews
//
//  Created by V K on 08.12.2022.
//

import UIKit

class ShapesCollectionViewCell: UICollectionViewCell {
    
    var shapesImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        shapesImageView.contentMode = .scaleAspectFit
        shapesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(shapesImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shapesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shapesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shapesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shapesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(shape: Shape) {
        shapesImageView.image = UIImage(named: shape.imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
