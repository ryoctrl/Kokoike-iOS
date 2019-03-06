//
//  API.swift
//  
//
//  Created by mosin on 2019/02/28.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    static let sharedInstance = API()
    
    private init() {
        
    }
    
    let session = URLSession.shared
    
    func get(urlStr: String, completion: @escaping(JSON) -> Void) {
        Alamofire.request(urlStr).responseJSON{ response in
            guard let obj = response.result.value else { return }
            print("getted")
            print(obj)
            completion(JSON(obj))
        }
    }
    
    func post(urlStr: String, params: [String:Any], completion: @escaping (JSON) -> Void) {
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        Alamofire.request(urlStr, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            guard let obj = response.result.value else { return }
            completion(JSON(obj))
        }
    }
    
    func getShops(word: String, completion: @escaping(JSON) -> Void) {
         let url = Constants.BACKEND_URL + Constants.ENDPOINTS.SHOPS + "?word=" + word.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        get(urlStr: url) { obj in
            completion(obj)
        }
    }
    
    func postGPS(lat: Float, lon: Float, completion: @escaping(JSON) -> Void) {
        let uid = UserDefaults.standard.string(forKey: "user")
        var url: String = Constants.BACKEND_URL + Constants.ENDPOINTS.GPS + "?user_id=" + uid!
        url += "&lat=" + String(lat)
        url += "&lon=" + String(lon)
        get(urlStr: url, completion: completion)
        //post(urlStr: url, params: params,  completion: completion)
    }
    
    func getLocations(completion: @escaping(JSON) -> Void) {
        
    }
    
    func createLocation(location: Location, completion: @escaping(JSON) -> Void) {
        let params: [String:Any] = [
            "name": location.name as Any,
            "address": location.address as Any,
            "url": location.url as Any,
            "comments": location.comment as Any,
            "lat": location.lat as Any,
            "lon": location.lon as Any,
            "tel": location.tel as Any,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_KEYS.ID) as Any,
            "image_url": location.image_url as Any
            ]
        let url = Constants.BACKEND_URL + Constants.ENDPOINTS.LOCATIONS
        post(urlStr: url, params: params,  completion: completion)
    }
    
    func getAuthURL() -> String{
        return Constants.BACKEND_URL + Constants.ENDPOINTS.AUTH
    }
}
