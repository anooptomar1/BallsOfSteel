//
//  WorldPhysics.swift
//  GameCube
//
//  Created by Michał.Krupa on 12.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit

class WorldPhysics: NSObject {

    public let gForce:Float
    public let maxGSpeed:Float
    
    override init() {
        maxGSpeed = -0.0005
        gForce    = -0.00001
    }
    
    init(maxFallSpeed maxGSpeed:Float, gForce:Float) {
        self.maxGSpeed  = maxGSpeed < 0 ? maxGSpeed : -1 * maxGSpeed
        self.gForce     = gForce < 0 ? gForce : -1 * gForce
    }
}
