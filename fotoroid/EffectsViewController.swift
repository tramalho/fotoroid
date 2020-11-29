//
//  EffectsViewController.swift
//  fotoroid
//
//  Created by Thiago Antonio Ramalho on 16/11/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class EffectsViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var photo: UIImageView!

    var image: UIImage!
    
    private lazy var filterManager: FilterManager = {
        return FilterManager(image: image)
    }()
    
    private let filterName = [
    "comic","sepia","halftone",
    "crystallize","vignette","noir"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func showLoading(_ show: Bool) {
        loadingView.isHidden = !show
    }
}

extension EffectsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterManager.filterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let effectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EffectsCollectionViewCell {
            effectCell.image.image = UIImage(named: filterName[indexPath.row])
            cell = effectCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let type = FilterType(rawValue: indexPath.row) {
            showLoading(true)
            DispatchQueue.global(qos: .userInitiated).async {
              let filteredImage = self.filterManager.apply(filterType: type)
                DispatchQueue.main.async {
                    self.photo.image = filteredImage
                    self.showLoading(false)
                }
            }
        }
    }
}
