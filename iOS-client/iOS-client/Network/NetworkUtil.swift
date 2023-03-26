//
//  File.swift
//  SelfSignedSSLCertDemo
//
//  Created by Saman khan on 26/03/2023.
//

class NetworkConstants {
    private init() {}
    
    static let baseURL = "localhost" // <Update the server address>
    static let port = "9000" // <Update the port>
    
    /// method
    static let health = "health"
    
    enum Method {
        case GET, POST
    }
}

enum NetworkError: Error {
     case Error(String)
}
