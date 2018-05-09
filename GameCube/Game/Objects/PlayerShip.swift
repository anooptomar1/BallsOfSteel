//
//  PlayerShip.swift
//  GameCube
//
//  Created by Michał Krupa on 08.05.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import SceneKit

class PlayerShip: NSObject {
    
    static let nodeName         = "PlayerShip"
    static let nodereference    = "PlayerMainShip reference"
    private var startPosition   = SCNVector3Make(0, 0, 0)
    
    let shipInclination:CGFloat = 0.5
    
    
    var currPosition:SCNVector3
    let playerNode:SCNNode!
    let pointOfInterest:SCNNode!
    var actions:Array<SCNAction>
    var inclination:CGVector = CGVector(dx: 0, dy: 0)
    
    init(withNode pNode:SCNNode, position:SCNVector3) {
        
        playerNode                  = pNode
        pointOfInterest             = pNode.childNode(withName: "PointOfInterest", recursively: false)
        actions                     = Array<SCNAction>()
        startPosition               = position
        currPosition                = startPosition
        playerNode.worldPosition    = startPosition
        
    }
    
    public func get(inclination:CGVector) {
        print("player inclination \(inclination)")
        self.inclination = inclination
    }
    
    public func calcMove() {
        if inclination != CGVector(dx: 0, dy: 0) {
            
            if abs(playerNode.worldPosition.z + Float(inclination.dx * shipInclination * -1)) < 50 {
                playerNode.worldPosition.z += Float(inclination.dx * shipInclination * -1)
            }
            
            if abs(playerNode.worldPosition.y + Float(inclination.dy * shipInclination)) < 50 {
                playerNode.worldPosition.y += Float(inclination.dy * shipInclination)
            }
        }
    }
    
    /**
     TODO: Przekazujemy bitmaske obiektu
     */
    public func calcColision() {
        
    }
}
