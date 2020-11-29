//
//  FinalViewController.swift
//  fotoroid
//
//  Created by Thiago Antonio Ramalho on 16/11/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit
import Photos

class FinalViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
        photo.layer.borderWidth = 10
        photo.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func save(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { (status) in
            if .authorized == status {
                self.saveToAlbum()
            } else {
                self.alert(title: "Erro", message: "É necessário autorização para salvar a imagem.")
            }
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveToAlbum() {
        
        PHPhotoLibrary.shared().performChanges({
            
            if let image = self.image {
                let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let addAssetRequest = PHAssetCollectionChangeRequest()
                
                if let phObjectPlaceholder = createAssetRequest.placeholderForCreatedAsset {
                    addAssetRequest.addAssets([phObjectPlaceholder] as NSArray)
                }
            }
            
        }) { (success, error) in
            
            var title = "Erro"
            var message = "Falha ao tentar salvar imagem"
            
            if success {
                title = "Sucesso"
                message = "Imagem salva no album de fotos!"
            }
            
            self.alert(title: title, message: message)
        }
    }
    
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
