//
//  CameraViewController.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import AVFoundation
//import CoreML
//import Vision

final class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

//
//    @IBOutlet var retakeButton: UIButton!
    
    var backVC : itemCreateNewViewController?
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var captureBTN: UIButton!
    @IBOutlet var temporalImageView: UIImageView!
    @IBOutlet var exitButton: UIButton!
    
    @IBOutlet var preView: UIView!
    
    var photoData : Data?
    
    
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
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            
            let input = try AVCaptureDeviceInput(device: backCamera!)
            captureSession?.addInput(input)
            photoOutPut = AVCapturePhotoOutput()
            
            //se puede cambiar por un guard ?
            if (captureSession?.canAddOutput(photoOutPut!) != nil) {
                
                captureSession?.addOutput(self.photoOutPut!)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(self.previewLayer!)
                captureSession?.startRunning()
            }
        } catch  {
            print("Error: \(error)")
        }
        previewLayer?.frame = self.cameraView.bounds
        previewLayer?.videoGravity = .resizeAspectFill

    }
    
    
    //función del protocolo AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let error = error {
            print("ERROR: \(error)")
            return
        }
        
        //guardamos la imagen que se ha tomado
        photoData = photo.fileDataRepresentation()
        let image = UIImage(data: photoData!)
        let cgImage = image?.cgImage
        let widht = CGFloat(cgImage!.width)
        let height = CGFloat(cgImage!.height)
        let cropRect = CGRect(x: (widht/2) - 360.0,
                              y: (height/2) - 360.0,
                              width: 720.0,
                              height: 720.0)
        
        let img = cgImage?.cropping(to: cropRect)
        temporalImageView.image = UIImage(cgImage: img!, scale: 1.0, orientation: image!.imageOrientation)
        openPreview()
    }
    
    
    func openPreview(){
        self.view.addSubview(preView)
        preView.bounds = self.view.bounds.applying(CGAffineTransform(scaleX: 0.95, y: 0.95))
        preView.center = self.view.center
    }
    
    @IBAction func okSavePhoto(){
        
        if backVC?.arrayImages == nil {
            backVC?.initializeArray()
        }
        backVC?.arrayImages?.append(temporalImageView.image!)
        backVC?.reloadCollection()
        
        let image = UIImageJPEGRepresentation(temporalImageView.image!, 0.5)
        backVC?.arrayData?.append(image!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedTakePhoto(){
        photoOutPut?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        captureBTN.isHidden = true
        exitButton.isHidden = true
    }
    
    @IBAction func cancelPreview(){
        preView.removeFromSuperview()
        exitButton.isHidden = false
        captureBTN.isHidden = false
    }

}
