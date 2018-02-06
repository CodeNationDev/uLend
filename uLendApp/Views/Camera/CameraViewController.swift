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

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

//    @IBOutlet var tempImageView: UIImageView!
//
//    @IBOutlet var captureButton: UIButton!
//    @IBOutlet var retakeButton: UIButton!
    
    @IBOutlet var cameraView: UIView!
    
    
    //variables de la cámara
    var captureSession: AVCaptureSession?
    var photoOutPut: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
}


extension CameraViewController {
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
