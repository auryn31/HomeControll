import Foundation
import Alamofire

class LoadData {
    
    var indicator = UIActivityIndicatorView()
    var enableView:((Bool)->Void)?
    
    func loadData(indicator: UIActivityIndicatorView, pin:Int, on:Int, loadView: @escaping ((Bool)->Void)){
        self.indicator = indicator
        loadView(true)
        Alamofire.request("http://192.168.178.67/test1.php?pin=" + String(pin) + "&switchState=" + String(on)).responseJSON(completionHandler: { response in
            indicator.stopAnimating()
            loadView(false)
            if let json = response.result.value {
                if let stringJSON = json as? Dictionary<String, String>{
                    print(stringJSON["Pin"] ?? "fail")
                    print(stringJSON["Success"] ?? "fail")
                }
                
            }
        })
    }
}
