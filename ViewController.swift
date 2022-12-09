//
//  ViewController.swift
//  CollectionViews
//
//  Created by V K on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    let roundShapesButton = UIButton()
    let pointyShapesButton = UIButton()
    
    let circle = Shape(imageName: "circle")
    let triangle = Shape(imageName: "triangle")
    let umbrella = Shape(imageName: "umbrella")
    let star = Shape(imageName: "star")
    
    
    var shapes: [Shape] = []
    var allShapes: [Shape] = []
    var filterSelected: [Bool] = [false, false]
    let shapeReuseIdentifier: String = "shapeReuseIdentifier"
    
    
    var collectionView: UICollectionView!
    let spacing: CGFloat = 10

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shapes"
        view.backgroundColor = UIColor(named: "background")
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(named: "background") ?? UIColor.gray.cgColor, UIColor.black.cgColor]
        view.layer.addSublayer(gradientLayer)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        shapes = [circle, circle, circle, circle,
                  triangle, triangle, triangle, triangle,
                  umbrella, umbrella, umbrella, umbrella,
                  star, star, star, star]
        allShapes = shapes
        
        
        roundShapesButton.setTitle("Round Shapes", for: .normal)
        roundShapesButton.backgroundColor = .darkGray
        roundShapesButton.layer.borderWidth = 0.5
        roundShapesButton.layer.borderColor = UIColor.white.cgColor
        roundShapesButton.setTitleColor(.white, for: .normal)
        roundShapesButton.translatesAutoresizingMaskIntoConstraints = false
        roundShapesButton.layer.cornerRadius = 15
        roundShapesButton.tag = 0
        roundShapesButton.addTarget(self, action: #selector(filterShapes), for: .touchUpInside)
        view.addSubview(roundShapesButton)
        
        pointyShapesButton.setTitle("Pointy Shapes", for: .normal)
        pointyShapesButton.backgroundColor = .darkGray
        pointyShapesButton.layer.borderWidth = 0.5
        pointyShapesButton.layer.borderColor = UIColor.white.cgColor
        pointyShapesButton.setTitleColor(.white, for: .normal)
        pointyShapesButton.translatesAutoresizingMaskIntoConstraints = false
        pointyShapesButton.layer.cornerRadius = 15
        pointyShapesButton.tag = 1
        pointyShapesButton.addTarget(self, action: #selector(filterShapes), for: .touchUpInside)
        view.addSubview(pointyShapesButton)
        
        
        let shapeLayout = UICollectionViewFlowLayout()
        shapeLayout.minimumLineSpacing = spacing
        shapeLayout.minimumInteritemSpacing = spacing
        shapeLayout.scrollDirection = .vertical
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: shapeLayout)
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShapesCollectionViewCell.self, forCellWithReuseIdentifier: shapeReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        setupConstraints()
        
    }
    
    @objc func filterShapes(sender: UIButton) {
        shapes = []
        
        filterSelected[sender.tag].toggle()
        sender.isSelected.toggle()
        
        if(sender.isSelected) {
            sender.backgroundColor = .lightGray
        } else {
            sender.backgroundColor = .darkGray
        }
        
        if(filterSelected[0]) {
            shapes += allShapes.filter { $0.imageName == "umbrella" || $0.imageName == "circle" }
        }
        if(filterSelected[1]) {
            shapes += allShapes.filter { $0.imageName == "triangle" || $0.imageName == "star" }
        }
        
        
        if(filterSelected[0] == filterSelected[1]) {
            shapes = allShapes
        }
        
        print(filterSelected)
        
        collectionView.reloadData()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            roundShapesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            roundShapesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            roundShapesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
        NSLayoutConstraint.activate([
            pointyShapesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pointyShapesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pointyShapesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
        
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: roundShapesButton.bottomAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shapeReuseIdentifier, for: indexPath) as? ShapesCollectionViewCell {
            cell.configure(shape: shapes[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 10) / 2.0
        return CGSize(width: size, height: size)
    }
}

