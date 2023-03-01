//
//  Common.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
// Common is for

import Foundation
import UIKit

class Common : NSObject {
    class func showAlertWithTitle(strMessage : String , title : String) {
        var alertMessage = UIAlertController(title:title, message: strMessage, preferredStyle: UIAlertController.Style.alert)
        
        if UserDefaults.standard.bool(forKey: "darkmode") == true{
            alertMessage = UIAlertController(title: title, message: strMessage, preferredStyle: .alert, blurStyle: .dark)
        }
        
        alertMessage.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if let vcs = delegate.window?.rootViewController{
            vcs.present(alertMessage, animated: true, completion: nil)
        }
    }
}
extension UIColor {
    
    class func AppWhite() -> UIColor {
        return UIColor(named: "AppWhite") ?? .white
    }
    
    class func AppBlack() -> UIColor{
        return UIColor(named: "AppBlack") ?? .black
    }
    
    class func MainTheme() -> UIColor{
        return UIColor(named: "MainTheme")!
    }
    
    convenience init?(hexString: String) {
        
        if hexString.count < 1 {
            
            return nil
        }
        
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}
extension UIFont {
    
    class func appFontRegular(ofSize size:CGFloat) -> UIFont {
        
        return UIFont(name: Global.Font.SYSTEMMEDIUM, size: size)!
    }
    
    class func appFontBold(ofSize size:CGFloat) -> UIFont {
        
        return UIFont(name: Global.Font.SYSTEMBOLD, size: size)!
    }
    
    class func appFontLight(ofSize size:CGFloat) -> UIFont {
        
        return UIFont(name: Global.Font.SYSTEMLIGHT, size: size)!
    }
}
