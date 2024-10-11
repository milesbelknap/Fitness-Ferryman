//
//  MyTableViewController.swift
//  Fitness Ferrymen
//
//  Created by Miles Belknap on 4/25/21.
//  Copyright © 2021 Miles Belknap. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    public var models: [(String, (() -> Void))] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        models[indexPath.row].1()
    }
}
