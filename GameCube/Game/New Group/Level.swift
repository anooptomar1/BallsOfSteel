//
//  Level.swift
//  GameCube
//
//  Created by Michał.Krupa on 08.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit



class Level: NSObject, GameProtocol {
 
    var state: GameStateType    = .start
    var mainCameraName          = "GameCamera"
    var scenePath               = "Media.scnassets/Levels/Level1.scn"

    var scene: SCNScene
    var hud: SKScene
    var sceneCamera: SCNNode
    let player:PlayerShip
    
    override init() {
        
        hud         = ScreenPad(size: (UIApplication.shared.windows.first?.frame.size)!)
        state       = .play
        scene       = SCNScene(named: scenePath)!
        sceneCamera = scene.rootNode.childNode(withName: mainCameraName, recursively: true)!
        player      = PlayerShip(withNode: scene.rootNode.childNode(withName: PlayerShip.nodereference, recursively: true)!, position: SCNVector3Make(-15, 0, 0))
        
        super.init()
        
        sceneCamera.constraints         = [SCNLookAtConstraint(target: player.pointOfInterest)]
        (hud as! ScreenPad).padDelegate = self
        
        calculateShipBounds()
    }

    //TODO: Kastomowy init wraz z levelem 'wsadowym'
    /* init(level:GameProtocol) { } */
    
   
    func updateState(atTime time:TimeInterval) {
        player.calcMove()
    }
    
    func commitAllAnimations() { 

    }
 
    private func calculateShipBounds() {
        
        guard let viewSize = UIApplication.shared.windows.first?.frame.size else { return }
        guard let yDeg = sceneCamera.camera?.fieldOfView else { return }
        let xDeg = viewSize.width/viewSize.height*yDeg
        let diff = CGFloat(abs(sceneCamera.worldPosition.x - player.currPosition.x))
        
        // Tan nie przyjmuje stopni!!!1
        print("tan45 \(tan(45.0))")
        
        let ySize = tan(yDeg * diff) * 2
        let xSize = tan(xDeg * diff) * 2
        
        
        
    }
    
}

extension Level: ScreenPadDelegate {
    func right(padInclination: CGVector) {
        player.get(inclination: padInclination)
    }
}

extension Level: SCNPhysicsContactDelegate {
    
    /*********************************************************************************************
     Bardzo ważna uwaga!
     physicWordl didBeign i didEnd mogą wywolywac sie kilka razy pomiomo ustanowionego kontaktu!!!
     Nalezy o tym pamiętac i sprawdzać stan w didUpdate
    **********************************************************************************************/
    
    func physicsWorld(_ world: SCNPhysicsWorld, didUpdate contact: SCNPhysicsContact) {
        guard state == .play else {
            return
        }
//        player.calculateContinuePlayer(bitmaskFor: contact)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        guard state == .play else {
            return
        }
//        player.calculateEndPlayer(bitmaskFor: contact)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        guard state == .play else {
            return
        }
//        player.calculateStartPlayer(bitmaskFor: contact)
    }
}

