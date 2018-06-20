//
//  MapViewController.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/19.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    let realm = try! Realm()
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var textBox: UITextField!
    var locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    var longNum: Float!
    var latNum: Float!
    var flag: Bool = false
    let storage = UserDefaults.standard
//    var locationArray = [Float]()
//    var nameContainLocationArray = [String(),[Float]()] as [Any]
//    var mainLocationArray = [[String(),[Float]()]] as [[Any]]
    var num : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMap.delegate = self
        locationManager.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //位置情報サービスの確認
        CLLocationManager.locationServicesEnabled()
        
        // セキュリティ認証のステータス
        let status = CLLocationManager.authorizationStatus()
        
        if(status == CLAuthorizationStatus.notDetermined) {
            print("NotDetermined")
            // 許可をリクエスト
            locationManager.requestWhenInUseAuthorization()
            
        }
        else if(status == CLAuthorizationStatus.restricted){
            print("Restricted")
        }
        else if(status == CLAuthorizationStatus.authorizedWhenInUse){
            print("authorizedWhenInUse")
        }
        else if(status == CLAuthorizationStatus.authorizedAlways){
            print("authorizedAlways")
        }
        else{
            print("not allowed")
        }
        
        // 位置情報の更新
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            print("更新しました\(num)")
            num += 1
            //中心座標
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//            print(location.coordinate.latitude)
//            print(location.coordinate.longitude)
           
            if flag == false{
                lat.text = String(location.coordinate.latitude)
                long.text = String(location.coordinate.longitude)
                //表示範囲
                let span = MKCoordinateSpanMake(0.1, 0.1)
                //中心座標と表示範囲をマップに登録する。
                let region = MKCoordinateRegionMake(center, span)
                myMap.setRegion(region, animated:true)
                myMap.setRegion(region,animated:true)
                latNum = Float(location.coordinate.latitude)
                longNum = Float(location.coordinate.longitude)
//                locationArray = [latNum,longNum]
                annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                myMap.addAnnotation(annotation)
                flag = true
            }
           
          
        }
    }
    
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        myMap.removeAnnotation(annotation)
        if sender.state == .ended{
            let location = sender.location(in: myMap)
            let mapPoint = myMap.convert(location, toCoordinateFrom: myMap)
            latNum = Float(mapPoint.latitude)
            longNum = Float(mapPoint.longitude)
//            locationArray = [latNum,longNum]
            print("lat\(latNum),long\(longNum)")
            lat.text = String(latNum)
            long.text = String(longNum)
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            myMap.addAnnotation(annotation)
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        if let text = textBox.text, latNum != nil, longNum != nil{
            let contents = Location()
            contents.name = text
            contents.latitude = latNum
            contents.longtitude = longNum
            try! realm.write() {
                realm.add(contents)
            }
            print(realm.objects(Location.self))
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    
}

