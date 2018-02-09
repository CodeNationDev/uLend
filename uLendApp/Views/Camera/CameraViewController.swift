//
//  CameraViewController.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

final class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

//
//    @IBOutlet var retakeButton: UIButton!
    
    var backVC : itemCreateNewViewController?
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var captureBTN: UIButton!
    @IBOutlet var temporalImageView: UIImageView!
    @IBOutlet var exitButton: UIButton!
    
    @IBOutlet var preView: UIView!
    
    
    //variables de la cámara
    var captureSession: AVCaptureSession?
    var photoOutPut: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        
        initCamera()
    }


    
}


extension CameraViewController {
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func initCamera(){
        
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            self.captureSession?.addInput(input)
            
            self.photoOutPut = AVCapturePhotoOutput()
            
            
            //se puede cambiar por un guard ?
            if (self.captureSession?.canAddOutput(self.photoOutPut!) != nil) {
                self.captureSession?.addOutput(self.photoOutPut!)
                
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
                self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                self.cameraView.layer.addSublayer(self.previewLayer!)
                self.captureSession?.startRunning()
            }
            
            
        } catch  {
            print("Error: \(error)")
        }
        
        self.previewLayer?.frame = self.view.bounds
        
        
        
    }
    
    
    //función del protocolo AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error = error {
            print("ERROR: \(error)")
            return
        }
        
        //guardamos la imagen que se ha tomado
        let photoData = photo.fileDataRepresentation()
        let image = UIImage(data: photoData!)
        
        //lo cargamos en la imagen de la view
//        temporalImageView.image = image!
        
        openPreview()
        temporalImageView.image = image!
        
        
        
        
//        backVC?.prueba.image = image!
//        dismiss(animated: true, completion: nil)
    }
    
    
    func openPreview(){
        self.view.addSubview(preView)
        preView.bounds = self.view.bounds.applying(CGAffineTransform(scaleX: 0.8, y: 0.8))
        preView.center = self.view.center
        
        
        
    }
    
    
    @IBAction func okSavePhoto(){
        
        if self.backVC?.arrayImages == nil {
            print("entramos aquí")
            self.backVC?.initializeArray()
        }
        
        self.backVC?.prueba.image = temporalImageView.image!
        self.backVC?.arrayImages?.append(temporalImageView.image!)
        self.backVC?.reloadCollection()
        
        print(self.backVC?.arrayImages?.count)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pressedTakePhoto(){
        self.photoOutPut?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        self.captureBTN.isHidden = true
        self.exitButton.isHidden = true
    }
    
    
    @IBAction func cancelPreview(){
        self.preView.removeFromSuperview()
        self.exitButton.isHidden = false
        self.captureBTN.isHidden = false
    }
    

    
}
