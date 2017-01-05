import UIKit

class TableViewController: UITableViewController {
    
    let availableContollers = ["Stehlampe", "Tischlampe", "Klo"]
    let mapToPins = ["Stehlampe":12, "Tischlampe":11, "Klo":10]
    var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()        
    }

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableContollers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ControllTableViewCell
        if let cell = cell {
            cell.label.text = availableContollers[indexPath.row]
            cell.switch?.setOn(false, animated: true)
            cell.indicator = indicator
            cell.pin = mapToPins[availableContollers[indexPath.row]]
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }
    }

}
