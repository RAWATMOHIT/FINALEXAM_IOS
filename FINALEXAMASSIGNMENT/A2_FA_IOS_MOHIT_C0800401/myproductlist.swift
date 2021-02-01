import UIKit
class myproductlist: UIViewController {
@IBOutlet weak var tblView: UITableView!
@IBOutlet weak var txtSearch: UITextField!

var mohitproduct: [Product] = []
override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtSearch.text = ""
        self.checkProducts()
    }
func checkProducts()  {
        if let product = mainbase().readAllProducts() {
            self.mohitproduct.removeAll()
            self.mohitproduct.append(contentsOf: product)
            tblView.reloadData()
        }
    }
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.txtSearch.resignFirstResponder()
        if let controller = segue.destination as? specificationproduct {
            controller.mohitproduct = sender as? Product
        }}
}
extension myproductlist: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    mohitproduct.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = mohitproduct[indexPath.row]
        labelItem?.text = product.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = mohitproduct[indexPath.row]
        self.performSegue(withIdentifier: "productListToDetail", sender: product)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = mohitproduct[indexPath.row]
            mohitproduct.remove(at: indexPath.row)
            mainbase().deleteProduct(product)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension myproductlist: UITextFieldDelegate {
    func enterField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string).lowercased()
            if let product = mainbase().readAllProducts() {
            if updatedText.isEmpty {
                    self.mohitproduct.removeAll()
                    self.mohitproduct.append(contentsOf: product)
                }
                else {
                    let items = product.filter({($0.productName!.lowercased().contains(updatedText))})
                    self.mohitproduct.removeAll()
                    self.mohitproduct.append(contentsOf: items)
                }
                self.tblView.reloadData()
        }
        }
        return true
    }
    
    func enterFielReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
