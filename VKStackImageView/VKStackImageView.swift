//
//  VKStackImageView.swift
//  VKStackImageView
//
//  Created by Vamshi Krishna on 20/04/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import Foundation
import UIKit


class VKStackImageView: UIView {
    
    
    var isGalleryOpen = false
    var images = [StackCardImage]()
    
    init(imageNamesArray : [String]) {
        let frame:CGRect = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-64)
        super.init(frame: frame)

        for i in 0..<imageNamesArray.count{
            let dm = StackCardImage(imageNamed: imageNamesArray[i])
            images.append(dm)
        }

        for image in images {
            image.layer.anchorPoint.y = 0.0
            image.frame = bounds
            image.bounds = frame
            addSubview(image)
            image.didSelect = selectImage
        }
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/250.0

        self.layer.sublayerTransform = perspective

    }
    
    
    func selectImage(selectedImage: StackCardImage) {
        
        for subview in self.subviews {
            guard let image = subview as? StackCardImage else {
                continue
            }
            if image === selectedImage {
                UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn, animations: {
                    image.layer.transform = CATransform3DIdentity
                }, completion: { _ in
                    self.bringSubview(toFront: image)
                })
            } else {
                UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn, animations: {
                    image.alpha = 0.0
                }, completion: { _ in
                    image.alpha = 1.0
                    image.layer.transform = CATransform3DIdentity
                })
            }
        }
        
        isGalleryOpen = false
    }

     func toggleGallery() {
        
        if isGalleryOpen {
            for subview in self.subviews {
                guard let image = subview as? StackCardImage else {
                    continue
                }
                
                let animation = CABasicAnimation(keyPath: "transform")
                animation.fromValue = NSValue(caTransform3D: image.layer.transform)
                animation.toValue = NSValue(caTransform3D: CATransform3DIdentity)
                animation.duration = 0.33
                
                image.layer.add(animation, forKey: nil)
                image.layer.transform = CATransform3DIdentity
                
            }
            
            isGalleryOpen = false
            return
        }
        
        var imageYOffset: CGFloat = 25.0
        
        for subview in self.subviews {
            
            guard let image = subview as? StackCardImage else {
                continue
            }
            
            var imageTransform = CATransform3DIdentity
            imageTransform = CATransform3DTranslate(imageTransform, 0.0, imageYOffset, 0.0)
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.7, 1.0)
            imageTransform = CATransform3DRotate(imageTransform, .pi/8, -1.0, 0.0, 0.0)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: image.layer.transform)
            animation.toValue = NSValue(caTransform3D: imageTransform)
            animation.duration = 0.33
            image.layer.add(animation, forKey: nil)
            
            image.layer.transform = imageTransform
            imageYOffset += self.frame.height / CGFloat(images.count)
        }
        isGalleryOpen = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class StackCardImage: UIImageView {
    
    var didSelect: ((StackCardImage)->())?
    
    convenience init(imageNamed: String) {
        self.init()
        
        image = UIImage(named: imageNamed)
        contentMode = .scaleAspectFill
        clipsToBounds = true
       
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func didMoveToSuperview() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(StackCardImage.didTapHandler(_:))))
    }
    
    @objc func didTapHandler(_ tap: UITapGestureRecognizer) {
        didSelect?(self)
    }
}
