import UIKit

class SellerProductview: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var mohitproduct: [Product]?
override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
    }
    
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? specificationproduct {
        controller.mohitproduct = sender as? Product
    }
}}
extension SellerProductview: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mohitproduct?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = mohitproduct?[indexPath.row]
        labelItem?.text = product?.productName
        return cell}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = mohitproduct?[indexPath.row]
        self.performSegue(withIdentifier: "providerProductToDetail", sender: product)
    }

}

