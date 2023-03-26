//
//  Network.swift
//  SelfSignedSSLCertDemo
//
//  Created by Shameem Ahamad on 26/03/2023.
//

import Foundation



protocol API {
    func healthCheck(completion: @escaping (Data?, Error?) -> Void)
}

class NetworkClient: NSObject, API {
    
    /// Check connection
    func healthCheck(completion: @escaping (Data?, Error?) -> Void) {

        guard let url = try? getHealthCheckEndpoint() else { return }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(nil, NetworkError.Error("Unknow error"))
                return
            }
            completion(data, nil)
        }
        dataTask.delegate = self
        dataTask.resume()
    }
    
}

extension NetworkClient: URLSessionTaskDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        /// You can write cusotm methode to verify the server certificate  from application bundle
        if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
            return
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
}

extension NetworkClient {
    func getHealthCheckEndpoint() throws -> URL  {
        guard let url = URL(string: "https://\(NetworkConstants.baseURL):\(NetworkConstants.port)/\(NetworkConstants.health)") else {
            throw NetworkError.Error("Failed to generate URL")
        }
        return url
    }
}
