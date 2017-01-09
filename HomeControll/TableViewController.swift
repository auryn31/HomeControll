import UIKit
import SwiftHEXColors

class TableViewController: UITableViewController {
    
    var availableContollers = ["Stehlampe", "Tischlampe", "Klo"]
    var mapToPins = ["Stehlampe":12, "Tischlampe":11, "Klo":10]
    var indicator = UIActivityIndicatorView()
    var enableView = UIView()
    let pinAssetsController = PinAssets()
    let timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        addHiddenFrame()
        activityIndicator()
        if let avCon = pinAssetsController.getAvailableControllers(), let mapP = pinAssetsController.getMapToPins() {
            availableContollers = avCon
            mapToPins = mapP
        }else {
            pinAssetsController.saveArray(available: availableContollers, defaultsArr: mapToPins)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let avCon = pinAssetsController.getAvailableControllers(), let mapP = pinAssetsController.getMapToPins() {
            availableContollers = avCon
            mapToPins = mapP
        }
        tableView.reloadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bounds = self.view.bounds
        enableView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        
    }
    
    func addHiddenFrame(){
        enableView.backgroundColor = UIColor(hexString: "000000", alpha: 0.4)
        self.view.addSubview(enableView)
        enableView.isHidden = true
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func enableBackground(value:Bool){
        enableView.isHidden = !value
    }

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
            cell.enableView = enableBackground
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let editController = EditViewController()
//        editController.editRow = indexPath.row
//        navigationController?.pushViewController(editController, animated: true)
//    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editController" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let editController = segue.destination as! EditViewController
                editController.editRow = indexPath.row

            }
        }
    }

}
