//
//  Camera.swift
//  GameCube
//
//  Created by Michał Krupa on 08.05.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import SceneKit

class Camera: NSObject {

    var cameraNode:SCNNode
    
    init(withCamera node:SCNNode) {
        cameraNode = node
    }
    
    
}
