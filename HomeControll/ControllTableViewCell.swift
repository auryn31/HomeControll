import UIKit

class ControllTableViewCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    var indicator = UIActivityIndicatorView()
    var pin:Int?
    var enableView:((Bool)->Void)?
    
    @IBAction func switchTrigger(_ sender: UISwitch) {
        let load = LoadData()
        var on = 0
        if(self.switch.isOn){
            on = 1
        }
        
        func pinSetTo(value:Bool){
            self.switch.setOn(value, animated: true)
            enableView!(false)
        }
        
        if let pin = pin, let enableView = enableView {
            load.loadData(indicator: indicator, pin: pin, on: on, pinResponse: pinSetTo)
            enableView(true)
            indicator.startAnimating()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
    }
    
    func update(){
        let loadData = LoadData()
        loadData.getPinsStatus(pin: self.pin!, pinResponse: { isOn in
            self.switch.isOn = isOn
        })        
    }
    
    
}
