//
//  TableViewController.swift
//  Web_Socket_Currents
//
//  Created by Вадим Пустовойтов on 20/02/2020.
//  Copyright © 2020 Вадим Пустовойтов. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var currents = Currents()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService.shared.webSocketClose()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currents.currents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = currents.currents[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ViewChartsSID") as! ViewController
        vc2.title = currents.currents[indexPath.row]
        vc2.pair = currents.pair[indexPath.row]
        //NetworkService.shared.webSocketClose()
        self.navigationController?.show(vc2, sender: nil)

    }

}
