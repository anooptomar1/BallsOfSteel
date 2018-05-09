//
//  GameState.swift
//  GameCube
//
//  Created by Michał.Krupa on 19.02.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

enum GameStateType:Int {
    
    case start  = 0
    case play   = 1
    case pause  = 2
    case end    = 3
    
}
 
protocol GameProtocol {
    
    var hud:SKScene { get set }
    var scene:SCNScene { get set }
    var scenePath:String { get set }
    var sceneCamera:SCNNode { get set }
    var state:GameStateType { get set }
    var mainCameraName:String { get set }
    
    func updateState(atTime time:TimeInterval) 
    
}




