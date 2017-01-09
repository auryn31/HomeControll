import Foundation

class PinAssets {
    let defaults = UserDefaults.standard
    
    struct defaultsKeys {
        static let availableContollers = "availableContollers"
        static let mapToPins = "mapToPins"
    }
    
    func saveArray(available:[String], defaultsArr:[String:Int]){
        defaults.set(available, forKey: defaultsKeys.availableContollers)
        defaults.set(defaultsArr, forKey: defaultsKeys.mapToPins)
        
        defaults.synchronize()
    }
    
    
    func getAvailableControllers()->[String]?{
        return defaults.stringArray(forKey: defaultsKeys.availableContollers)
    }
    
    func getMapToPins()->[String:Int]? {
        return defaults.dictionary(forKey: defaultsKeys.mapToPins) as? [String:Int]
    }
}
