//
//  ViewController.swift
//  fotoroid
//
//  Created by Thiago Antonio Ramalho on 10/11/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EffectsViewController, let image = sender as? UIImage {
            vc.image = image
        }
    }
    
    @IBAction func selectSource(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar foto", message: "Origem", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = createAction(title: "Câmera") { (UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let bibliotecaAction = createAction(title: "Biblioteca") { (UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(bibliotecaAction)
        
        let albumAction = createAction(title: "Álbum") { (UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let cancelAction = createAction(title: "Cancelar")
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func createAction(title: String, action: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: action)
    }
    
    private func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.sourceType = sourceType
        uiImagePickerController.delegate = self
        present(uiImagePickerController, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let aspectRatio = image.size.width / image.size.height
            var smallSize = CGSize(width: 1000 * aspectRatio, height: 1000)
            
            if aspectRatio > 1 {
                smallSize = CGSize(width: 1000, height: 1000/aspectRatio)
            }
            
            UIGraphicsBeginImageContext(smallSize)
            image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
            let smallImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dismiss(animated: true) {
                self.performSegue(withIdentifier: "effectSegue", sender: smallImage)
            }
        }
    }
}


