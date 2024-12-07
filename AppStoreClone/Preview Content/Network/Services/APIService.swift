//
//
// APIService.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//


import Foundation

public enum APIClientError: APIClientErrorRepresentable {
    case noBaseURL
    case badURL
    case other(String)
    
    public var description: String {
        switch self {
            case .noBaseURL:
                return "Base URL not set in the configuration!"
            case .badURL:
                return "Couldn't form url request, bad url!"
            case .other:
                return "Unkown"
        }
    }
}

public protocol APIClientErrorRepresentable: Error {
    var description: String { get }
}

public protocol APIRequestable {
    var path: String { get }
    var method: String { get }
    var headers: [String: Any]? { get }
    var body: Data? { get }
    var baseURL: URL? { get }
    var shouldRetry: Bool { get }
    var shouldStubResponse: Bool { get }
    var stubbedResponseData: Data? { get }
}

public typealias APIResult<T, U> = Result<T, U> where T: Decodable, U: APIClientErrorRepresentable

public protocol APIClientExecutable: Sendable {
    func execute<T: Decodable & Sendable>(_ request: APIRequestable) async -> APIResult<T, APIClientError>
}


public final class APIService: APIClientExecutable {
    
    public func execute<T: Decodable & Sendable>(_ request: APIRequestable) async -> APIResult<T, APIClientError> {
        
#if DEBUG
        // Check if stubbed response should be used
        if request.shouldStubResponse,
           let stubbedData = request.stubbedResponseData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: stubbedData)
                return .success(decodedData)
            } catch let error {
                return APIResult.failure(APIClientError.other(error.localizedDescription))
            }
        }
#endif
        return APIResult.failure(APIClientError.other("Implement API Service"))
    }
}
