//
//  ViewController.swift
//  Web_Socket_Currents
//
//  Created by Вадим Пустовойтов on 18/02/2020.
//  Copyright © 2020 Вадим Пустовойтов. All rights reserved.
//

import UIKit
import Charts
import SwiftWebSocket

class ViewController: UIViewController {

    @IBOutlet weak var charts: LineChartView!
    
    var months: [String]!
    var unitsSold: [Double]!
    var stringMessage: [Double] = []
    var pair: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("pair " + pair)
        guard let url = URL(string:"wss://api.bitfinex.com/ws") else { return }
        NetworkService.shared.startSocket(url: url, pair: pair) { response in
            print("RESPONSE: " + response)
            let responseString = response.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
            let strings = responseString.split(separator: ",")
            for eachString in strings {
                // Convert each string to Double
                
                if let num = Double(eachString) { //Double(String) returns an optional.
                    self.stringMessage.append(num)
                } else {
                    print("Error converting to Double")
                }
                
                
            }
            if self.stringMessage.count == 11 {
                self.chartsUpdate(priceCurrents: self.stringMessage[1])
            } else {
                self.stringMessage = []
            }
        }
        
        months = []
        unitsSold = []
        
        charts.xAxis.labelPosition = .bottom
        charts.xAxis.drawGridLinesEnabled = false
        charts.xAxis.avoidFirstLastClippingEnabled = true
        
        charts.rightAxis.drawAxisLineEnabled = false
        charts.rightAxis.drawLabelsEnabled = false
        
        charts.leftAxis.drawAxisLineEnabled = false
        charts.pinchZoomEnabled = false
        charts.doubleTapToZoomEnabled = false
        charts.legend.enabled = false
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        charts.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        charts.xAxis.setLabelCount(months.count, force: true)
        
        charts.data = chartData
        
    }
    
    func chartsUpdate(priceCurrents: Double) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        
        if months.count == 5 {
            months.remove(at: 0)
            unitsSold.remove(at: 0)
        }
        
        months.append(stringDate)
        unitsSold.append(priceCurrents)
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
}

