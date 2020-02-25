//
//  JsonRequest.swift
//  Web_Socket_Currents
//
//  Created by Вадим Пустовойтов on 21/02/2020.
//  Copyright © 2020 Вадим Пустовойтов. All rights reserved.
//

import Foundation

struct JsonRequest {
    var json = [String:AnyObject]()
    init(pair: String) {
        json["event"] = "subscribe" as AnyObject
        json["channel"] = "ticker" as AnyObject
        json["pair"] = pair as AnyObject
    }
}
