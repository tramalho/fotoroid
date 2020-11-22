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

    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
