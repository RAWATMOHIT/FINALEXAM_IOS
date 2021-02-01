import UIKit
protocol newaddedit: class {
    func updateProductItems(_ product: Product?)
}
class NewEditAdd: UIViewController {

    @IBOutlet weak var enterProductId: UITextField!
    @IBOutlet weak var enterProductName: UITextField!
    @IBOutlet weak var enterProductPrice: UITextField!
    @IBOutlet weak var enterProductProvider: UITextField!
    @IBOutlet weak var enterProductDescription: UITextView!
    
    weak var delegate: newaddedit?

    var mohitproduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialSetup()
    }
    
    func intialSetup()  {
        if let product = mohitproduct {
            enterProductId.text = String(product.productId )
            enterProductName.text = product.productName
            enterProductPrice.text = String(product.productPrice)
            enterProductProvider.text = product.productProvider
            enterProductDescription.text = product.productDescription
        }
        
    }
    
    @IBAction func didTapSaveBtn(_ sender: Any) {
        if (enterProductId.text?.isEmpty ?? false) ||
            (enterProductName.text?.isEmpty ?? false) ||
            (enterProductPrice.text?.isEmpty ?? false) ||
            (enterProductProvider.text?.isEmpty ?? false) ||
            (enterProductDescription.text?.isEmpty ?? false){
            showAlert(message: "Please fill all the field", options: ["Ok"], completion: nil)
        }
        else {
            if let product = mohitproduct {
                product.productId = Int16(enterProductId.text ?? "") ?? 0
                product.productName = enterProductName.text ?? ""
                product.productPrice = Double(enterProductPrice.text ?? "") ?? 0
                product.productProvider = enterProductProvider.text ?? ""
                product.productDescription = enterProductDescription.text ?? ""
                basedata.sharedCoreData.saveContext()
                
                self.delegate?.updateProductItems(product)
            }
            else {
                let dictProduct = ["productId"          : enterProductId.text ?? "",
                                   "productPrice"       : enterProductPrice.text ?? "",
                                   "productName"        : enterProductName.text ?? "",
                                   "productDescription" : enterProductDescription.text ?? "",
                                   "productProvider"    : enterProductProvider.text ?? ""]
                mainbase().enterProducts(dictProduct)
            }
        }
    }
}


extension NewEditAdd: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.enterProductId {
            self.enterProductName.becomeFirstResponder()
        }
        else if textField == self.enterProductName {
            self.enterProductPrice.becomeFirstResponder()
        }
        else if textField == self.enterProductPrice {
            self.enterProductProvider.becomeFirstResponder()
        }
        else if textField == self.enterProductProvider {
            self.enterProductDescription.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let frame = self.view.convert(textField.frame, from:textField.superview)
        let val = (self.view.frame.height - 260) - frame.maxY
        if val < 0 {
            animateViewMoving(up: true, moveValue: val)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat = 0){
        UIView.animate(withDuration: 0.5,delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: moveValue, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

}

extension NewEditAdd: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let frame = self.view.convert(textView.frame, from:textView.superview)
        let val = (self.view.frame.height - 260) - frame.maxY
        if val < 0 {
            animateViewMoving(up: true, moveValue: val)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false)
    }
    
}
