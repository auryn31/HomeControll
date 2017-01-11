import Foundation
import Alamofire

class LoadData {
    
    var indicator = UIActivityIndicatorView()
    var enableView:((Bool)->Void)?
    
    func loadData(indicator: UIActivityIndicatorView, pin:Int, on:Int, pinResponse: @escaping ((Bool)->Void)){
        
        self.indicator = indicator
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        let url = "http://192.168.178.51/test1.php?pin="+String(pin)+"&switchState="+String(on)
        sessionManager.request(url, method: .post, parameters: nil)
            .responseJSON {
                response in
                switch (response.result) {
                case .success:
                    if let json = response.result.value {
                        if let stringJSON = json as? Dictionary<String, String>{
//                            print(stringJSON["Pin"] ?? "fail")
//                            print(stringJSON["Success"] ?? "fail")
                            if(stringJSON["Success"] == "TRUE"){
                                pinResponse(true)
                            } else {
                                pinResponse(false)
                            }
                        }
                        
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("Server nicht erreichbar")
                    }
                    if(on==1){
                        pinResponse(false)
                    } else {
                        pinResponse(true)
                    }
                    break
                }
                sessionManager.session.invalidateAndCancel()
        }
    }
    
    func getPinsStatus(pin:Int, pinResponse: @escaping ((Bool)->Void)){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        let url = "http://192.168.178.51/test1.php?pinStatus="+String(pin)
        sessionManager.request(url, method: .post, parameters: nil)
            .responseJSON {
                response in
                switch (response.result) {
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
                sessionManager.session.invalidateAndCancel()
        }
    }
}
