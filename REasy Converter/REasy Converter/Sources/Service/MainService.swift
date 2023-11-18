//
//  MainService.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 24/04/23.
//

import NetworkTasks
import UIKit

protocol MainServiceProtocol {
    func fetchCurrencies(completion: @escaping (Result<[CurrencyServiceModel]>) -> Void)
//    func fetchExchangeRates(forUser userId: Int, completion: @escaping ([ExchangeRate]?, Error?) -> Void)
//    func updateExchangeRate(_ exchangeRate: ExchangeRate, forUser userId: Int, completion: @escaping (Error?) -> Void)
}

struct PCRequest1: NetworkRequest {
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

class MainService: MainServiceProtocol {
    
    private let network: NetworkTasks
    private let baseURL: String
    
    init(network: NetworkTasks = NetworkTasks.shared) {
        self.network = network
        self.baseURL = "https://reasyconverter-default-rtdb.firebaseio.com"
    }
    
    func fetchCurrencies(completion: @escaping (Result<[CurrencyServiceModel]>) -> Void) {
    // https://reasyconverter-default-rtdb.firebaseio.com/currenciesV2
        let url = baseURL.appending("/currenciesV2.json")
        
        let requestForAmount = PCRequest1(endpoint: url, method: .get)
        // PCRequest1(endpoint: url, method: .get)
        print("**********1*************")
        network.send(requestForAmount) { (result: Result<AmountOfCurrencies>) in
            switch result {
            case .success(let data):
                print(data)
                print("NUMBER OF CURRENCIES AVAILABLE TO DOWNLOAD: \(data.amount)")
                self.fetchListOfCurrencies(amount: data.amount) { (result: Result<[CurrencyServiceModel]>) in
                    switch result {
                    case .success(let currencies):
                        completion(.success(currencies))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let erro):
                completion(.failure(erro))
            }
        }
        print("***********2************")
        
    }
    
    private func fetchListOfCurrencies(amount: Int, completion: @escaping (Result<[CurrencyServiceModel]>) -> Void) {
        let url = baseURL.appending("/currencies/")
        let json = ".json"
        var currencies = [CurrencyServiceModel]()
        
        (0...amount-1).forEach { [weak self] index in
            print(index)
            let url = url.appending(String(index)).appending(json)
            let request = PCRequest1(endpoint: url, method: .get)

            self?.network.send(request) { (result: Result<CurrencyServiceModel>) in
                switch result {
                case .success(let data):
                    print(data)
                    currencies.append(data)
                    if currencies.count == amount {
                        completion(.success(currencies))
                    }
                case .failure(let erro):
                    completion(.failure(erro))
                }
            }
        }

    }
    //    func fetchExchangeRates(forUser userId: Int, completion: @escaping ([ExchangeRate]?, Error?) -> Void) {
    //        let url = baseURL.appendingPathComponent("/users/\(userId)/exchange-rates")
    //        let task = session.dataTask(with: url) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(nil, error)
    //                return
    //            }
    //            do {
    //                let exchangeRates = try JSONDecoder().decode([ExchangeRate].self, from: data)
    //                completion(exchangeRates, nil)
    //            } catch {
    //                completion(nil, error)
    //            }
    //        }
    //        task.resume()
    //    }
    //
    //    func updateExchangeRate(_ exchangeRate: ExchangeRate, forUser userId: Int, completion: @escaping (Error?) -> Void) {
    //        let url = baseURL.appendingPathComponent("/users/\(userId)/exchange-rates/\(exchangeRate.id)")
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "PUT"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        do {
    //            request.httpBody = try JSONEncoder().encode(exchangeRate)
    //        } catch {
    //            completion(error)
    //            return
    //        }
    //        let task = session.dataTask(with: request) { data, response, error in
    //            guard error == nil else {
    //                completion(error)
    //                return
    //            }
    //            completion(nil)
    //        }
    //        task.resume()
    //    }
    
}
