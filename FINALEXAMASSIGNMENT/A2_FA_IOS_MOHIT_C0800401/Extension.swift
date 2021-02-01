import UIKit
extension UIView {
    
    @IBInspectable
    var smallpoint: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var bwidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var bColor: UIColor? {
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
}}
extension UIViewController {
    func showAlert(title: String = "", message: String, options: [String]? = nil, completion: ((Int) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let options = options {
            for (index, option) in options.enumerated() {
                alertController.addAction(UIAlertAction(title: option, style: .default, handler: { (action) in
                    completion?(index)
                }))
            }
        }
self.present(alertController, animated: true, completion: nil)
    }
}
