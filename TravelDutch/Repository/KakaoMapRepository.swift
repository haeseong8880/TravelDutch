//
//  KakaoMapApi.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/18.
//

import Foundation

class KakaoMapRepository {
    static let shared = KakaoMapRepository()
    
    func fetchKaKaoApi(of destination: String, completionHandler: @escaping (Result<KakaoMapEntity, Error>) -> Void) {
        let urlStr = "https://dapi.kakao.com/v2/local/search/address.json?query=\(destination)"
        guard let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let urlEncode = URL(string: encoded) else { return }
        var request = URLRequest(url: urlEncode)
        request.httpMethod = "GET"
        request.setValue("KakaoAK 98fbcdbbc31cafc0b918088f27de68e5", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let searchCoordinate = try? JSONDecoder().decode(KakaoMapEntity.self, from: data) else {
                print("ERROR: URLSettion data task \(error?.localizedDescription ?? "")")
                return
            }
            switch response.statusCode {
            case (200...299):
                print("DEBUG: \(searchCoordinate)")
                completionHandler(.success(searchCoordinate))
            case (400...499):
                print("Error: Client \(response.statusCode)")
                completionHandler(.failure("Error: Client" as! Error))
            case (500...599):
                print("Error: Server \(response.statusCode)")
                completionHandler(.failure("Error: Server" as! Error))
            default:
                print("Error: Server \(response.statusCode)")
            }
        }
        dataTask.resume()
    }
}
