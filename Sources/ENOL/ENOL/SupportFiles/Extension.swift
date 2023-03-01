//
//  Extension.swift
//  ENOL
//
//  Created by TVPC000013 on 07/02/23.
// Extension for the extension of the Components


import Foundation
import SDWebImage

var topMostViewControllers: UIViewController? {
    var presentedVC = UIApplication.shared.keyWindow?.rootViewController
    while let controller = presentedVC?.presentedViewController {
        presentedVC = controller
    }
    return presentedVC
}

extension UIImageView {
    
    func loadImage(string: String) {
        if string.contains(".") {
            self.sd_setImage(with: URL(string: string), completed: nil)
        } else {
            self.image = UIImage(named: string)
        }
    }
    
}

extension UIAlertController {
    
    private struct AssociatedKeys {
        static var blurStyleKey = "UIAlertController.blurStyleKey"
    }
    
    public var blurStyle: UIBlurEffect.Style {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.blurStyleKey) as? UIBlurEffect.Style ?? .extraLight
        } set (style) {
            objc_setAssociatedObject(self, &AssociatedKeys.blurStyleKey, style, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    public var cancelButtonColor: UIColor? {
        return blurStyle == .dark ? UIColor(red: 28.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1.0) : nil
    }
    
    public convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style, blurStyle: UIBlurEffect.Style) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        self.blurStyle = blurStyle
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Heebo-SemiBold", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }

}
extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    @available(iOS 15, *)
    func formatDateString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = Locale(identifier: "en") // set locale to reliable US_POSIX
        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:self) ?? dateFormatter2.date(from: self)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute,], from: date ?? Date.now)
        let formatedDate = String("\(components.hour!):\(components.minute!)")
       // return formatedDate
     //   let dateFormatter = DateFormatter()
          //dateFormatter.dateFormat = "h:mm a"
          dateFormatter.calendar = Calendar.current
          dateFormatter.timeZone = TimeZone.current
          
          if let date = dateFormatter.date(from: self) {
              dateFormatter.timeZone = TimeZone(abbreviation: "UTC+11:00")
              dateFormatter.dateFormat = "hh:mm a"
          
              return dateFormatter.string(from: date)
          }
          return formatedDate
    }
    
    func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
            guard let font = font else {
                return htmlToAttributedString
            }
            let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
            guard let data = modifiedString.data(using: .utf8) else {
                return nil
            }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
            catch {
                print(error)
                return nil
            }
        }
    
}

extension UIViewController {
    func presentToast(_ smartToastViewController: LoafViewController) {
        smartToastViewController.transDelegate = Manager(loaf: smartToastViewController.loaf, size: smartToastViewController.preferredContentSize)
        smartToastViewController.transitioningDelegate = smartToastViewController.transDelegate
        smartToastViewController.modalPresentationStyle = .custom
        smartToastViewController.view.clipsToBounds = true
        smartToastViewController.view.layer.cornerRadius = 6
        DispatchQueue.main.async { [weak self] in
            self?.present(smartToastViewController, animated: true, completion: nil)
        }
    }
    
    func stringConvertCryptoFiatPriceAmount(isCrypto: Bool, amount : String) -> String {
        var value = amount
        let price : Double = Double(amount) ?? 0
        if isCrypto == true {
            value = String(format: "%.8f", price)
        } else {
            value = String(format: "%.2f", price)
        }
        return value
    }
    
    func doubleConvertCryptoFiatPriceAmount(isCrypto: Bool, amount : Double) -> String {
        var value = ""
        if isCrypto == true {
            value = String(format: "%.8f", amount)
        } else {
            value = String(format: "%.2f", amount)
        }
        return value
    }
    
    func allString<T>(value: T) -> String{
        return String(format: "%.8f", value as! String)
    }
    
    
    func getCurrentTimeStamp() -> String {
        let currentTime = NSDate().timeIntervalSince1970
        return "\(currentTime)"
    }
    
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        var alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if UserDefaults.standard.bool(forKey: "darkmode") == true{
            alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle, blurStyle: .dark)
        }
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
}
extension Date{
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}
extension UIColor {
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            
            return UIColor.magenta
        }
        
        var rgb: UInt32 = 0
        Scanner.init(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
    
}
extension UIView {
    
    
//    func failureToast(msg: String) {
//        let success = MessageView.viewFromNib(layout: .cardView)
//        success.configureTheme(.error)
//        success.configureContent(title: "Alert", body: msg)
//        //        success.configureContent(title: "Alert!", body: Msg, iconImage: UIImage.init(named: "NotificationIcon")!, viewTapHandler:  { _ in
//        //            print("Notification View Tap")
//        //            SwiftMessages.hide()
//        //        })
//
//        //success.configureContent(title: Msg, body: "")
//        success.button?.isHidden = true
//        var successConfig = SwiftMessages.defaultConfig
//        successConfig.presentationStyle = .bottom
//        //successConfig.duration = .seconds(seconds: 2)
//        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
//        SwiftMessages.show(config: successConfig, view: success)
//    }
    
//    func successToast(msg: String) {
//        let success = MessageView.viewFromNib(layout: .cardView)
//        success.configureTheme(.success)
//        success.configureContent(title: "Success", body: msg)
//        //        success.configureContent(title: "Alert!", body: Msg, iconImage: UIImage.init(named: "NotificationIcon")!, viewTapHandler:  { _ in
//        //            print("Notification View Tap")
//        //            SwiftMessages.hide()
//        //        })
//        
//        //success.configureContent(title: Msg, body: "")
//        success.button?.isHidden = true
//        var successConfig = SwiftMessages.defaultConfig
//        successConfig.presentationStyle = .bottom
//        //successConfig.duration = .seconds(seconds: 2)
//        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
//        SwiftMessages.show(config: successConfig, view: success)
//    }
}
