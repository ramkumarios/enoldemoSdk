//
//  CustomUI.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableTextField: UITextField {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableTabBar: UITabBar {
}

@IBDesignable

class DesignableViewCustomCorner: UIView {
    
    @IBInspectable var cornerRadious: CGFloat = 0 {
        didSet {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
}

extension UILabel {
    
    @IBInspectable var lightModeColorLabel : UIColor?{
        get {
            if let color = textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    
                    textColor = newValue
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeColorLabel : UIColor?{
        get {
            if let color = textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    
                    textColor = newValue
                }
            }
        }
        
    }
    
    
}

extension UITabBar {
    
    @IBInspectable var BlackWhiteThemeTextColor: UIColor? {
        get {
            if let color = barTintColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set {
            if newValue != nil {
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    barTintColor = UIColor.black
                } else {
                    barTintColor = newValue
                }
            } else {
                barTintColor = nil
            }
        }
    }
    
}

extension UITextField {
    
    
    @IBInspectable var lightModeColortextField : UIColor?{
        get {
            if let color = textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    
                    textColor = newValue
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeColortextField : UIColor?{
        get {
            if let color = textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    
                    textColor = newValue
                }
            }
        }
        
    }
    
}

extension UITextView {
    
    @IBInspectable var BlackWhiteThemeTextColor: UIColor? {
        get {
            if let color = textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set {
            if newValue != nil {
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    textColor = newValue
                } else {
                    textColor = UIColor.black
                }
            } else {
                textColor = nil
            }
        }
    }
}

extension UIButton {
    
    
    @IBInspectable var lightModeColorButton : UIColor?{
        get {
            if let color = titleLabel?.textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    setTitleColor(newValue, for: .normal)
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeColorButton : UIColor?{
        get {
            if let color = titleLabel?.textColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    setTitleColor(newValue, for: .normal)
                }
            }
        }
        
    }
    
    
}

extension UIImageView {
    
    @IBInspectable var lightModeColorButton : UIColor?{
        get {
            if let color = tintColor{
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    tintColor = newValue
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeColorButton : UIColor?{
        get {
            if let color = tintColor {
                return UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    tintColor = newValue
                }
            }
        }
        
    }
    
    @IBInspectable var lightModeImage : UIImage?{
        get {
            if let color = image{
                return UIImage(cgImage: color.cgImage!)// UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    image = newValue
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeImage : UIImage?{
        get {
            if let color = image {
                return UIImage(cgImage: color.cgImage!)// UIColor(cgColor: color.cgColor)
            }
            return nil
        }
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    image = newValue
                }
            }
        }
        
    }
    
}

extension UIView {
    
    
    @IBInspectable var lightModeColorView : UIColor?{
        get {
            if let color = layer.backgroundColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == false {
                    layer.backgroundColor = newValue?.cgColor
                    
                }
            }
        }
        
    }
    
    @IBInspectable var darkModeColorView : UIColor?{
        get {
            if let color = layer.backgroundColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set{
            if newValue != nil{
                if UserDefaults.standard.bool(forKey: "darkmode") == true {
                    layer.backgroundColor = newValue?.cgColor
                }
            }
        }
        
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


@IBDesignable class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    @IBInspectable var topColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .yellow {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientshadowColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointX: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientcornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        self.gradientLayer = self.layer as? CAGradientLayer
        self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        self.layer.cornerRadius = gradientcornerRadius
        self.layer.shadowColor = gradientshadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        self.layer.shadowRadius = shadowBlur
        self.layer.shadowOpacity = 1
        
    }
    
    func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer?.colors
        let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
        self.gradientLayer?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.gradientLayer?.add(animation, forKey:"animateGradient")
    }
}

@IBDesignable
class PlainCircularProgressBar: UIView {
    @IBInspectable var color: UIColor? = .gray {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var ringWidth: CGFloat = 5
    
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color?.cgColor
    }
}
