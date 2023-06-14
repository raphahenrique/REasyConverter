//
//  FlagsService.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 13/06/23.
//

import NetworkTasks
import UIKit

protocol FlagsServiceProtocol {
    func fetchFlagImage(for countryCode: String, completion: @escaping (Result<UIImage>) -> Void)
}

struct PCRequest: NetworkRequest {
    typealias ResponseType = Data
    var endpoint: String
    var method: HTTPMethod = .get
    var parameters: [String : Any]?
    var headers: [String : String]?

    init(endpoint: String, method: HTTPMethod, parameters: [String : Any]? = nil, headers: [String : String]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

class FlagsService: FlagsServiceProtocol {

    private let network: NetworkTasks
    private let baseURL: String
    
    init(network: NetworkTasks = NetworkTasks.shared) {
        self.network = network
        self.baseURL = "https://flagsapi.com/"
    }
    
    internal func fetchFlagImage(for countryCode: String, completion: @escaping (Result<UIImage>) -> Void) {
        let flagURLString = baseURL + countryCode + "/flat/64.png"
        guard let _ = URL(string: flagURLString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = PCRequest(endpoint: flagURLString, method: .get)
        network.send(request) { (result: Result<Data>) in
            switch result {
            case .success(let data):
                print(data)
                guard let image = UIImage(data: data) else {
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                completion(.success(image))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }

}
