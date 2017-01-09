import Foundation
import Alamofire

class LoadData {
    
    var indicator = UIActivityIndicatorView()
    var enableView:((Bool)->Void)?
    
    func loadData(indicator: UIActivityIndicatorView, pin:Int, on:Int, pinResponse: @escaping ((Bool)->Void)){
        
        self.indicator = indicator
        
        Alamofire.request("http://192.168.178.51/test1.php", method: .get, parameters: ["pin":String(pin), "switchState":String(on)]).responseJSON(completionHandler: { response  in
            indicator.stopAnimating()
            switch (response.result){
            case .success:
                if let json = response.result.value {
                    if let stringJSON = json as? Dictionary<String, String>{
                        print(stringJSON["Pin"] ?? "fail")
                        print(stringJSON["Success"] ?? "fail")
                        if(stringJSON["Success"] == "TRUE"){
                            pinResponse(true)
                        } else {
                            pinResponse(false)
                        }
                    }
                    
                }
                break
            case .failure(let error):
                if(on==1){
                    pinResponse(false)
                } else {
                    pinResponse(true)
                }
                break
            }
            
        })
        
    }
    
    func getPinsStatus(pin:Int, pinResponse: @escaping ((Bool)->Void)){
        Alamofire.request("http://192.168.178.51/test1.php", method: .get, parameters: ["pinStatus":String(pin)]).responseJSON(completionHandler: { response  in
            switch (response.result){
            case .success:
                if let json = response.result.value {
                    if let stringJSON = json as? Dictionary<String, String>{
                        if(stringJSON["value"]?.contains("1"))!{
                            pinResponse(true)
                        } else {
                            pinResponse(false)
                        }
                    }
                    
                }
                break
            case .failure(let error):
                print(error)
                break
            }
            
        })
    }
}
