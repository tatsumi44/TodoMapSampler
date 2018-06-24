//
//  ViewController.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/19.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import MapKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var table: UITableView!
    var locationManager = CLLocationManager()
    let realm = try! Realm()
    var num: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        locationManager.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        num = indexPath.row
        performSegue(withIdentifier: "Next", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next"{
            let resulutViewController = segue.destination as! ResultViewController
            resulutViewController.num = self.num
        }
        
    }
    
    @IBAction func notification(_ sender: UIBarButtonItem) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { result, error in
           
        })
        let content = UNMutableNotificationContent()
        content.title = "たいとる"
        content.subtitle = "さぶたいとる"
        content.body = "ほんぶん"
        content.badge = NSNumber(value: 1)
        content.sound = UNNotificationSound.default()
        let trigger: UNNotificationTrigger
        let coordinate = CLLocationCoordinate2DMake(35.6972484989424, 139.439033372458)
        let region = CLCircularRegion(center: coordinate, radius: 1000.0, identifier: "description")
        trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        let request = UNNotificationRequest(identifier: "normal",
                                            content: content,
                                            trigger: trigger)
        // ローカル通知予約
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
//        let center = UNUserNotificationCenter.current()
      
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

