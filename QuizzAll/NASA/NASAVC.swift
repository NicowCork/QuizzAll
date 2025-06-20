//
//  NASAVC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 03/05/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit


class NASAVC: UIViewController, UIScrollViewDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    var imageUrl: URL? {
        didSet {
            print("imageURL model didset")
            imageView.image = nil
            imageView.sizeToFit()
            ui_scrollview.contentSize = imageView.frame.size
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    var titleUrl: String? {
        didSet {
            UIO_name.text = titleUrl
        }
    }
    
    @IBOutlet var UIO_name: UILabel!
    
    private var imageView = UIImageView()
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
   
    @IBOutlet var ui_scrollview: UIScrollView! {
        didSet {
            print("uiscrollview did set")
            ui_scrollview.addSubview(imageView)
            ui_scrollview.delegate = self
            ui_scrollview.maximumZoomScale = 5
            ui_scrollview.minimumZoomScale = 1/10
        }
    }
    
    private func getNewURl() {
        if let url_title = DataImage.NASA.randomElement() {
            print(url_title)
            let url = url_title.value, title = url_title.key
            
            titleUrl = title
            imageUrl = url
        }
    }
    
    private func fetchImage() {
        if let url = imageUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.imageView.image = UIImage(data: imageData)
                        self?.imageView.sizeToFit()
                        self?.ui_scrollview.contentSize = self!.imageView.frame.size
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    @IBAction func UIB_New(_ sender: UIButton) {
        activityIndicator.startAnimating()
        getNewURl()
    }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
   
}
