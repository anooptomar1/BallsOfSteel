//
//  OperatorsOverliad.swift
//  GameCube
//
//  Created by Michał.Krupa on 13.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import SceneKit

// AŻ dziw że nie ma tego zrobionego w SceneKit ale moze nie znalazlem
extension SCNVector3: Equatable {
    
    public static func ==(left: SCNVector3, right: SCNVector3) -> Bool {
        if left.x == right.x && left.y == right.y && left.z == right.z {
            return true
        }
        return false
    }
    
    public static func !=(left: SCNVector3, right: SCNVector3) -> Bool {
        if left.x == right.x && left.y == right.y && left.z == right.z {
            return false
        }
        return true
    } 
}

extension SCNVector3 {
    public static func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x+right.x, left.y+right.y, left.z+right.z)
    }
}
