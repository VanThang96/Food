//
//  Extensions.swift
//  Food
//
//  Created by win on 5/19/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


extension UIButton {
    func makeCornerAndGradient(startColor: UIColor , endColor : UIColor){
        layer.cornerRadius = frame.height / 2
        gradientColor(firstColor: startColor, secondColor: endColor)
        clipsToBounds = true
    }
    func gradientColor (firstColor : UIColor , secondColor : UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func makeCornerAndBorderButton(color : UIColor){
        layer.cornerRadius = frame.height / 2
        layer.borderWidth  = 2
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
}
extension UIImageView {
    func makeBlurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
    }
    func imageFromUrl(urlString: String) {
        let url = URL(string: urlString)!
        let placeholderImage = UIImage(named: "icon_image_placeholder")!
        let filter = AspectScaledToFillSizeFilter(size: self.frame.size)
        self.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: filter, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: nil)
    }
}
extension UITextField{
    /**
     add show or hide password into textField right
     */
    func addShowAndHidePassword(tapGesture : UITapGestureRecognizer , tintColor : UIColor ){
        let image = isSecureTextEntry ? "icon_visibility_off" : "icon_visibility"
        addRightView(image: image,tintColor : tintColor, tapGesture: tapGesture)
    }
    /**
     add a left view into textField left
     */
    func addLeftView(image : String , tintColor : UIColor) {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        containerView.backgroundColor = .clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tintColor
        imageView.backgroundColor = .clear
        imageView.center = containerView.center
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
    /**
     add a right view into textField right
     */
    fileprivate func addRightView(image : String ,tintColor : UIColor, tapGesture : UITapGestureRecognizer) {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        containerView.backgroundColor = .clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGesture)
        
        imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tintColor
        imageView.backgroundColor = .clear
        imageView.center = containerView.center
        containerView.addSubview(imageView)
        rightView = containerView
        rightViewMode = .always
    }
}
extension UIViewController {
    func showAlert(message : String!){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func displayToastMessage(_ message : String ,_ duration : Double ) {
        let estimatedHeightLabel = message.height(withConstrainedWidth:  self.view.frame.width * 2 / 5, font: UIFont.systemFont(ofSize: 16))
        
        let toastView = UILabel()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.font = UIFont.systemFont(ofSize: 16)
        toastView.layer.cornerRadius = 20
        toastView.layer.masksToBounds = true
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toastView)
        
        let horizontalCenter : NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let heightCostraint : NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: estimatedHeightLabel + 24)
        let widthConstraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.view.frame.width * 2 / 5)
        let bottomConstraint : NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -93)
        
        
        
        NSLayoutConstraint.activate([horizontalCenter,widthConstraint,heightCostraint,bottomConstraint])
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
}
extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
extension UIView {
    /**
    Corner radius and shadow for card view in FooddetailViewController
     */
    func cornerRadiusAndShadowForCardView() {
        layer.cornerRadius = 4
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
}
extension String {
    /**
    estimated height of label in FoodDetailViewController
     */
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
