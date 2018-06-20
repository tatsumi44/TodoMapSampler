//
//  Helper.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/19.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import Foundation
import RealmSwift


class Location: Object {
    @objc dynamic var name = ""
    @objc dynamic var latitude: Float = 0.0
    @objc dynamic var longtitude: Float = 0.0
}



