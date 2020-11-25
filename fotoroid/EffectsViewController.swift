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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photo.image = filterManager.apply(filterType: .noir)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
