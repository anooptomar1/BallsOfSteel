//
//  MainMenu.swift
//  GameCube
//
//  Created by Michał Krupa on 07.05.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class MainMenu: GameProtocol {
     
    var hud: SKScene
    var scene: SCNScene
    var sceneCamera: SCNNode
    
    var scenePath: String       = "Media.scnassets/Levels/MainMenu.scn"
    var state: GameStateType    = .play
    var mainCameraName: String  = "MenuCamera"
    
    init() {
        
        scene                               = SCNScene(named: scenePath)!
        sceneCamera                         = scene.rootNode.childNode(withName: mainCameraName, recursively: true)!
        hud                                 = MainMenu2D(size: (UIApplication.shared.windows.first?.frame.size)!)
        (hud as! MainMenu2D).menuDelegate   = self
        
    }
    
    func updateState(atTime time: TimeInterval) {
        
    }
    
}

extension MainMenu: MainMenu2DDelegate {
    func didPickStart() {
        GameManager.shared.didFinishCurrentLevel()
    }
}
