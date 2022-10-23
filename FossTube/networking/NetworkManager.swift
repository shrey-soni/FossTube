//
//  NetworkManager.swift
//  FossTube
//
//  Created by Shrey Soni on 09/08/22.
//


import Foundation
import Combine
import os

class NetworkManager {
    
    static let shared = NetworkManager()

    private var cancellables = Set<AnyCancellable>()
    
    let logger = Logger(subsystem: "fosstube", category: "network")

    func getData<T: Decodable>(absoluteUrl: String, id: Int? = nil, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: absoluteUrl) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            self.logger.log("Calling Url:-> \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            self.logger.error("Decoding error")
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            self.logger.error("Api error")
                            promise(.failure(apiError))
                        default:
                            self.logger.error("Unknown network error")
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}


enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
