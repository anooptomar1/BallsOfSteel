//
//  swift
//  GameCube
//
//  Created by Michał.Krupa on 09.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit

class Player: NSObject {

    
    let boxes               = ["topBox", "bottomBox", "leftBox", "rightBox"]
    let pointOfInterest     = "lookAtNode"
    let nameReference       = "player"
    var cameraLookAt        = SCNVector3Make(10, 9, 15)
    var currPosition        = SCNVector3Make(0, 0, 0)
    var acceleration        = SCNVector3Make(0, 0, 0)
    var actions             = Dictionary<String,SCNAction>()
    var actionsArr          = Array<SCNAction>()
    
    var jumpForce:Float     = 0.5
    var runSpeed:Float      = 0.5
    let minDiff:Float       = 0.1
    
    
    var contactPointLeft:SCNVector3?
    var contactPointRight:SCNVector3?
    var contactPointTop:SCNVector3?
    var contactPointBottom:SCNVector3?
    var height:Float
    var width:Float
    var length:Float
    var playerNode:SCNNode
    var playerPosition:SCNVector3
    
     
    init(scnNode:SCNNode, position:SCNVector3) {
        playerNode      = scnNode
        playerPosition  = position

        
        if let b = playerNode.childNode(withName: "player", recursively: true)?.boundingBox {
            width  = b.max.x - b.min.x
            height = b.max.y - b.min.y
            length = b.max.z - b.min.z
        } else {
            width  = 0.1
            height = 0.1
            length = 0.1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: PUBLICZNE FUNKCJE
    
    public func updatePosition(){
        
    }
    
    public func updateCameraLookAtPosition() {
        if acceleration.x < 0 && cameraLookAt.x > 0 || acceleration.x > 0 && cameraLookAt.x < 0{
            cameraLookAt.x = -1 * cameraLookAt.x
            playerNode.childNode(withName: pointOfInterest, recursively: false)?.runAction(SCNAction.move(to: cameraLookAt, duration: 0.7))
        }
    }
    
    public func commitMovement() {
        if acceleration != SCNVector3Zero {
            playerNode.worldPosition = playerNode.worldPosition + acceleration
        }
    }
    
    public func receive(inclination:CGVector) {
        if abs(inclination.dx) > 0.23 {
            if abs(inclination.dx) > 0.7 {
                acceleration.x = 0.7 * runSpeed * (inclination.dx > 0 ? 1 : -1)
            } else {
                acceleration.x = Float(inclination.dx) * runSpeed
            }
        } else if inclination.dx == 0 {
            acceleration.x = 0
        }
        
        if abs(inclination.dy) > 0.5 && contactPointBottom != nil {
            acceleration.y = jumpForce
        } else if abs(inclination.dy) < 0 {
            // TODO: Kucanko hehehe nie na siku
        }
        
        calculateMovement()
    }
    
    public func calculateContinuePlayer(bitmaskFor contact: SCNPhysicsContact) {
//        if (contact.nodeA.physicsBody?.categoryBitMask)! | (contact.nodeB.physicsBody?.categoryBitMask)! == ObjectType.BitMaskPlayerBox.rawValue | ObjectType.BitMaskObstacle.rawValue {
//            let playerBumper = (boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            let obstacle     = (!boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            calculateContactPoint(forBumperBox: playerBumper, andObstacle: obstacle)
//        }
    }
    
    public func calculateStartPlayer(bitmaskFor contact: SCNPhysicsContact) {
//        if (contact.nodeA.physicsBody?.categoryBitMask)! | (contact.nodeB.physicsBody?.categoryBitMask)! == ObjectType.BitMaskPlayerBox.rawValue | ObjectType.BitMaskObstacle.rawValue {
//            let playerBumper = (boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            let obstacle     = (!boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            calculateContactPoint(forBumperBox: playerBumper, andObstacle: obstacle)
//        }
    }
    
    public func calculateEndPlayer(bitmaskFor contact: SCNPhysicsContact) {
//        if (contact.nodeA.physicsBody?.categoryBitMask)! | (contact.nodeB.physicsBody?.categoryBitMask)! == ObjectType.BitMaskPlayerBox.rawValue | ObjectType.BitMaskObstacle.rawValue {
//            let playerBumper = (boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            let obstacle     = (!boxes.contains(contact.nodeA.name!) ? contact.nodeA : contact.nodeB )
//            calculateFinishContactPoint(forBumperBox: playerBumper, andObstacle: obstacle)
//        }
    }

    
    //MARK: PRYWATNE FUNKJCE
    
    private func calculateExpectedAcceleration() {
        
    }
    
    private func calculateMovement() {
        if contactPointBottom != nil && acceleration.y < 0 {
            let bottomPos = playerNode.worldPosition.y - height/2.0
            if bottomPos > (contactPointBottom?.y)! && bottomPos - minDiff + acceleration.y < (contactPointBottom?.y)! {
                acceleration.y = (contactPointBottom?.y)! - bottomPos + minDiff
            } else if bottomPos - minDiff <= (contactPointBottom?.y)! && acceleration.y < 0 {
                acceleration.y = 0
            }
        }
        if contactPointLeft != nil && acceleration.x < 0 {
            let leftPos = playerNode.worldPosition.x - width/2.0
            if leftPos > (contactPointLeft?.x)! && leftPos - minDiff + acceleration.x < (contactPointLeft?.x)! {
                acceleration.x = (contactPointLeft?.x)! - leftPos + minDiff
            } else if leftPos - minDiff <= (contactPointLeft?.x)! && acceleration.x < 0 {
                acceleration.x = 0
            }
        }
        if contactPointRight != nil && acceleration.x > 0 {
            let rightPos = playerNode.worldPosition.x + width/2.0
            if rightPos < (contactPointRight?.x)! && rightPos + minDiff + acceleration.x > (contactPointRight?.x)! {
                acceleration.x = 0
            } else if rightPos + minDiff >= (contactPointRight?.x)! && acceleration.x > 0 {
                // ?? KUrde po co to to nie wiem nie jestem pewien ale zostawiam
                print("O huj sprawdz to")
            }
        }
        if contactPointTop != nil && acceleration.y >= 0 {
            //TODO:Dokonczyc spotkanie ze sciana u gory
            /*let topPos = playerNode.worldPosition.y + height/2.0
            if topPos < (contactPointTop?.y)! && topPos + minDiff + acceleration.y > (contactPointTop?.y)! {
                acceleration.y = (contactPointBottom?.y)! - (playerNode.worldPosition.y - height/2.0) + minDiff
            } else if topPos - minDiff <= (contactPointBottom?.y)! && acceleration.y < 0 {
                acceleration.y = 0
            }*/
        }
    }
    
    private func calculateContactPoint(forBumperBox bumperBox:SCNNode, andObstacle obstBox:SCNNode) {
        if bumperBox.name == "topBox" {
            contactPointTop = SCNVector3Make(0, obstBox.worldPosition.y - 2.5, 0)
        } else if bumperBox.name == "bottomBox" {
            contactPointBottom = SCNVector3Make(0, obstBox.worldPosition.y + 2.5, 0)
            print("obstBox.worldPosition \(obstBox.worldPosition)")
        } else if bumperBox.name == "leftBox" {
            contactPointLeft = SCNVector3Make(obstBox.worldPosition.x + 5.0, 0, 0)
        } else if bumperBox.name == "rightBox" {
            contactPointRight = SCNVector3Make(obstBox.worldPosition.x - 5.0, 0, 0)
        }
    }
    
    private func calculateFinishContactPoint(forBumperBox bumperBox:SCNNode, andObstacle obstBox:SCNNode) {
        if bumperBox.name == "topBox" {
            print("TopEnd")
            contactPointTop = nil
        } else if bumperBox.name == "bottomBox" {
            print("BtmEnd")
            contactPointBottom = nil
        } else if bumperBox.name == "leftBox" {
            contactPointLeft = nil
        } else if bumperBox.name == "rightBox" {
            contactPointRight = nil
        }
    }
     
}
