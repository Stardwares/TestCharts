//
//  CurrentsStruct.swift
//  Web_Socket_Currents
//
//  Created by Вадим Пустовойтов on 21/02/2020.
//  Copyright © 2020 Вадим Пустовойтов. All rights reserved.
//

import Foundation

struct Currents {
    var currents: [String]
    var pair: [String]
    
    init() {
        self.currents = ["BTC/USD","ETH/USD","LTC/USD","XRP/USD","EOS/USD","ETC/USD","NEO/USD"]
        self.pair = ["BTCUSD","ETHUSD","LTCUSD","XRPUSD","EOSUSD","ETCUSD","NEOUSD"]
    }
}
