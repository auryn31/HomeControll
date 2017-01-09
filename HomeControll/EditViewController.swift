
import UIKit

class EditViewController: UIViewController {
    
    var editRow:Int?
    var availableContollers = ["Stehlampe", "Tischlampe", "Klo"]
    var mapToPins = ["Stehlampe":12, "Tischlampe":11, "Klo":10]
    let pinAssetsController = PinAssets()
    
    @IBOutlet weak var pin: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avCon = pinAssetsController.getAvailableControllers(), let mapP = pinAssetsController.getMapToPins() {
            availableContollers = avCon
            mapToPins = mapP
            if let editRow = editRow{
                name.text = avCon[editRow]
                pin.text = (String) (mapP[avCon[editRow]]!)
            }
        } else {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func done(_ sender: Any) {
        if let editRow = editRow{
            availableContollers[editRow] = name.text!
        } else {
            availableContollers.append(name.text!)
        }
        mapToPins[name.text!] = Int.init(pin.text!)
        pinAssetsController.saveArray(available: availableContollers, defaultsArr: mapToPins)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }


}
