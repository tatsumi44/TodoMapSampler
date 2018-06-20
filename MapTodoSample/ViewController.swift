//
//  ViewController.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/19.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let contents = realm.objects(Location.self)
        return contents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let contents = realm.objects(Location.self)
        let name = contents[indexPath.row].name
        cell.textLabel?.text = name
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

