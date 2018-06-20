//
//  ResultViewController.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/20.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
class ResultViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainMap: MKMapView!
    let realm = try! Realm()
    var num: Int!
    var data:Results<Location>!
    var locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = realm.objects(Location.self)
        locationManager.delegate = self
        mainMap.delegate = self
        nameLabel.text = data[num].name
        let center = CLLocationCoordinate2DMake(CLLocationDegrees(data[num].latitude), CLLocationDegrees(data[num].longtitude))
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(center, span)
        mainMap.setRegion(region, animated: true)
        annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(data[num].latitude), CLLocationDegrees(data[num].longtitude))
        mainMap.addAnnotation(annotation)
//        print(String(describing: type(of: data)))

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
