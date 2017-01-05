import Foundation
import Alamofire

class LoadData {
    
    var indicator = UIActivityIndicatorView()
    
    func loadData(indicator: UIActivityIndicatorView){
        self.indicator = indicator
        Alamofire.request("http://192.168.178.67/test1.php").responseJSON(completionHandler: { response in
            indicator.stopAnimating()
            if let json = response.result.value {
                if let stringJSON = json as? Dictionary<String, String>{
                    print(stringJSON["Test"])
                }
                
            }
        })
    }
}
