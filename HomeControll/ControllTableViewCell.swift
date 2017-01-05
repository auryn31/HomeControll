import UIKit

class ControllTableViewCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var indicator = UIActivityIndicatorView()
    var pin:Int?
    
    @IBAction func switchTrigger(_ sender: UISwitch) {
        let load = LoadData()
        var on = 0
        if(self.switch.isOn){
            on = 1
        }
        if let pin = pin {
            load.loadData(indicator: indicator, pin: pin, on: on)
            indicator.startAnimating()
        }
    }
    
    
}
