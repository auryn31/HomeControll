import Foundation
import Alamofire

class LoadData {
    
    var indicator = UIActivityIndicatorView()
    
    func loadData(indicator: UIActivityIndicatorView, pin:Int, on:Int){
        self.indicator = indicator
        Alamofire.request("http://192.168.178.67/test1.php?pin=" + String(pin) + "&switchState=" + String(on)).responseJSON(completionHandler: { response in
            indicator.stopAnimating()
            if let json = response.result.value {
                if let stringJSON = json as? Dictionary<String, String>{
                    print(stringJSON["Pin"] ?? "fail")
                    print(stringJSON["Success"] ?? "fail")
                }
                
            }
        })
    }
}
