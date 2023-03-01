
import Foundation
import Alamofire
import SwiftyJSON
import SKActivityIndicatorView

class Service {
    var AFManager = SessionManager()
//
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = 60 // seconds
//            configuration.timeoutIntervalForResource = 60 //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)

    static let shared: Service = Service()
    
    enum HTTPError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func post(urlString: String,param: [String:Any], completionBlock: @escaping (Swift.Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        print("URL \(url) \n param: \(param) ")
        let header = ["Content-Type" : "application/json"]
        print(header)
        AFManager.request(url, method: .post, parameters: param,encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        let jsonValue = JSON(json)
                        if jsonValue["message_code"].intValue == 10{
                            DispatchQueue.main.async{
                                Common.showAlertWithTitle(strMessage: jsonValue["message"].stringValue, title: "Session Out!")
                            }

                            print("Session Timeout")
                        }
                        
                        completionBlock(.success(data))
                    } catch {
                        completionBlock(.failure(error))
                        print(error)
                        let delegate = UIApplication.shared.delegate as! AppDelegate
                        if let vc = delegate.window?.rootViewController {
                            Loaf(error.localizedDescription, state: .custom(.init(backgroundColor: .systemRed)), location: .bottom, presentingDirection: .left, dismissingDirection: .right, sender: vc).show(.long)
                        }
                        
                    }
                }
                
                break
            case .failure(let error):
                completionBlock(.failure(error))
                SKActivityIndicator.dismiss()
                print(error)
            }
        }
    }
    
    
    public func get(urlString: String, completionBlock: @escaping (Swift.Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        print("URL \(url) \n param: .get ")
        
        AFManager.request(url, method: .get,encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        let jsonValue = JSON(json)
                        if jsonValue["message_code"].intValue == 10{
                            DispatchQueue.main.async{
                                Common.showAlertWithTitle(strMessage: jsonValue["message"].stringValue, title: "Session Out!")
                            }

                            print("Session Timeout")
                        }
                        
                        completionBlock(.success(data))
                    } catch {
                        completionBlock(.failure(error))
                        print(error)
                        let delegate = UIApplication.shared.delegate as! AppDelegate
                        if let vc = delegate.window?.rootViewController {
                            Loaf(error.localizedDescription, state: .custom(.init(backgroundColor: .systemRed)), location: .bottom, presentingDirection: .left, dismissingDirection: .right, sender: vc).show(.long)
                        }
                    }
                }
                
                break
            case .failure(let error):
                completionBlock(.failure(error))
                SKActivityIndicator.dismiss()
                print(error)
            }
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if let holdingView = topMostViewControllers?.view.subviews.filter({ $0.tag == 999999}).first {
                    SKActivityIndicator.dismiss()
                    holdingView.removeFromSuperview()
                }
            }
        }
    }

    
}
