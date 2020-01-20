//
//  ViewController.swift
//  ScrollViewSS
//
//  Created by M. Zharif Hadi M. Khairuddin on 19/01/2020.
//  Copyright © 2020 M. Zharif Hadi M. Khairuddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1 = UIImageView(image: UIImage(named: "ImageA"))
        image1.frame = CGRect(x: 0, y: 0*460, width: 320, height: 460)
        scrollView.addSubview(image1)
        
//        let image2 = UIImageView(image: UIImage(named: "ImageB"))
//        image2.frame = CGRect(x: 0, y: 1*460, width: 320, height: 460)
//        scrollView.addSubview(image2)
//
//        let image3 = UIImageView(image: UIImage(named: "ImageC"))
//        image3.frame = CGRect(x: 0, y: 2*460, width: 320, height: 460)
//        scrollView.addSubview(image3)
        
        scrollView.contentSize = CGSize(width: 320, height: 460)

    }

    @IBAction func clickedButton(_ sender: Any) {
        
        let img: UIImage?
        
        UIGraphicsBeginImageContext(scrollView.contentSize)
        
        let savedContentOffset = scrollView.contentOffset
        let savedFrame = scrollView.frame
        
        scrollView.contentOffset = .zero
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        scrollView.layer.render(in: context)
        img = UIGraphicsGetImageFromCurrentImageContext()
        
        scrollView.contentOffset = savedContentOffset
        scrollView.frame = savedFrame
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img!, self, nil, nil)
        if let img = img?.resizeImage() {
            UIImageWriteToSavedPhotosAlbum(img, self, nil, nil)
//            UIImageWriteToSavedPhotosAlbum(img, self, #selector(saveImageComplete(image:err:context:)), nil)
        }
    }
    
    @objc private func saveImageComplete(image:UIImage, err:NSError, context:UnsafeMutableRawPointer?) {

    }

}

extension UIImage {
    func resizeImage() -> UIImage? {
        let expWidth: CGFloat = 1100
        let imgWidth = self.size.width
        let imgHeight = self.size.height
        print(imgWidth)
        let scaleFactor = expWidth / imgWidth
        print(scaleFactor)
        let newImgWidth = imgWidth * scaleFactor
        let newImgHeight = imgHeight * scaleFactor
        print(self.size.width)
        print(newImgWidth)

        UIGraphicsBeginImageContext(CGSize(width: newImgWidth, height: newImgHeight))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: newImgWidth, height: newImgHeight)))
        let scaledImg = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImg
    }
}

