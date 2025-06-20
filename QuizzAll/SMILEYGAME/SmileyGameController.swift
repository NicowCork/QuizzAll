//
//  SmileyGameController.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 09/06/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class SmileyGameController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK: CaptureSession
    
    @IBOutlet weak var ui_preview: UIView!
    @IBOutlet weak var ui_label: UILabel!
    @IBOutlet weak var ui_confidence: UILabel!
    let captureSession = AVCaptureSession()
    
    @IBAction func startSessionButton(_ sender: UIButton) {
        if captureSession.isRunning {
            captureSession.stopRunning()
        } else {
            if captureSession.inputs.count == 0 {
                configureCaptureSession()
            }
            captureSession.startRunning()
        }
    }
    
    func configureCaptureSession() {
        // 1 - Configurer les entrees
        guard let frontCamera = AVCaptureDevice.devices().filter({$0.position == .front}).first else {
            fatalError("camera not found")
        }
        
        let cameraFeed = try? AVCaptureDeviceInput(device: frontCamera)
        captureSession.addInput(cameraFeed!)

        // 2 - Configurer les sorties
        let outFeed = AVCaptureVideoDataOutput()
        outFeed.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated))
        captureSession.addOutput(outFeed)
        
        // 3 - Configurer l'apercu
        let preview = AVCaptureVideoPreviewLayer(session: captureSession)
        preview.frame = ui_preview.bounds
        ui_preview.layer.addSublayer(preview)
          
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
        do {
            try imageRequestHandler.perform([imageRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    // MARK: CoreML
    
    lazy var imageRecognitionRequest: VNRequest = {
        let model = try! VNCoreMLModel(for: CNNEmotions().model)
        let request = VNCoreMLRequest(model: model, completionHandler: self.imageRecognitionHandler)
        return request
    }()

    func imageRecognitionHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation],
            let bestGuess = observations.first else {
                return
        }
        DispatchQueue.main.async {
            self.ui_label.text = bestGuess.identifier
            self.ui_confidence.text = "Confidence: \(bestGuess.confidence)"
        }
    }


}
