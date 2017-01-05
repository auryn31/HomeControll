import UIKit

class ControllTableViewCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var indicator = UIActivityIndicatorView()
    
    
    
    @IBAction func switchTrigger(_ sender: UISwitch) {
        let load = LoadData()
        load.loadData(indicator: indicator)
        indicator.startAnimating()
    }
    
    
}
