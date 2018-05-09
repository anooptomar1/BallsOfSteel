//
//  Scenario.swift
//  GameCube
//
//  Created by Michał.Krupa on 19.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit

protocol Scenario {

    var boardName:      String { get set }              // sciezka assetu scn
    var checkpoints:    Array<SCNVector3> { get set }
    var ammo:           Array<SCNVector3> { get set }
    var heal:           Array<SCNVector3> { get set }
    var weapons:        Array<SCNVector3> { get set }
    
}
