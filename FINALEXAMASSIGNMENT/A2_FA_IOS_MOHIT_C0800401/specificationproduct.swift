import UIKit
class specificationproduct: UIViewController, newaddedit {
    @IBOutlet var labelItems: [UILabel]!
    var mohitproduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changedProduct()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as?
            NewEditAdd {
            controller.mohitproduct = mohitproduct
            controller.delegate = self
        }
    }
    func updateProductItems(_ product: Product?) {
        self.mohitproduct = product
    }
    func changedProduct()  {
        labelItems[0].text = "Product ID: " + String(mohitproduct?.productId ?? 0)
        labelItems[1].text = "Product Name: " + (mohitproduct?.productName ?? "")
        labelItems[2].text = "Product Price: " + String(mohitproduct?.productPrice ?? 0)
        labelItems[3].text = "Product Provider: " + (mohitproduct?.productProvider ?? "")
        labelItems[4].text = "Product Description: " + (mohitproduct?.productDescription ?? "")
    }
}
