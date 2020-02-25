//
//  NetworkService.swift
//  Web_Socket_Currents
//
//  Created by Вадим Пустовойтов on 21/02/2020.
//  Copyright © 2020 Вадим Пустовойтов. All rights reserved.
//

import Foundation
import SwiftWebSocket

class NetworkService {
    
    private init() {}
    var isOpen: Bool = false
    var socket: WebSocket!
    static let shared = NetworkService()
    
    public func startSocket(url: URL, pair: String, completion: @escaping(String) -> ()) {
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket.allowSelfSignedSSL = true
        
        socket.event.open = {
            self.isOpen = true
            self.sendWasTapped(pair: pair)
            print("opened")
        }
        
        socket.event.close = { code, reason, clean in
            self.isOpen = false
            print("closed")
        }
        
        socket.event.error = { error in
            print("error \(error)")
        }
        
        socket.event.message = { message in
            if let text = message as? String {
                completion(text)
            }
        }
        
        socket.open()
        
    }
    
    func sendWasTapped(pair: String) {
        let jsonRequest = JsonRequest(pair: pair)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonRequest.json, options: JSONSerialization.WritingOptions.prettyPrinted);
            if let string = String(data: jsonData, encoding: String.Encoding.utf8) {
                socket.send(string)
                print("send")
            } else {
                print("Couldn't create json string");
            }
        } catch let error {
            print("Couldn't create json data: \(error)");
        }
        
    }
    
    func webSocketClose() {
        if isOpen {
            socket.close()
        }
    }
    
}
