//
//  ApiService.swift
//  CovidApp
//
//  Created by Giorgi Kratsashvili on 10/14/20.
//

import Foundation

typealias ApiServiceResponseHandler<T: Decodable> = (Result<ApiServiceResponse<T>, Error>) -> Void

protocol ApiService {
    func startRequest<T: Decodable>(request: ApiServiceRequest, completion: @escaping ApiServiceResponseHandler<T>)
}

class ApiServiceImplemetation: ApiService {

    // MARK: Singleton Shared Instance with default configuration

    static let defaultShared: ApiService = ApiServiceImplemetation(with: .default)

    let session: URLSession

    init(with configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }

    func startRequest<T: Decodable>(request: ApiServiceRequest, completion: @escaping ApiServiceResponseHandler<T>) {

        guard let request = request.urlRequest
        else {
            completion(.failure(CoreError(message: "Can not create request")))
            return
        }

        session.dataTask(with: request) { (data, response, error) in

            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse
            else {
                completion(.failure(CoreError(message: "Application did not get requested data")))
                return
            }

            let statusCode = httpResponse.statusCode
            guard (200 ..< 300) ~= statusCode
            else {
                completion(.failure(CoreError(message: "Http error occured with error code \(statusCode)")))
                return
            }

            let entity: T
            do { entity = try JSONDecoder().decode(T.self, from: data) }
            catch let error {
                completion(.failure(error))
                return
            }

            let response = ApiServiceResponse(entity: entity)

            completion(.success(response))

        }.resume()
    }
}
