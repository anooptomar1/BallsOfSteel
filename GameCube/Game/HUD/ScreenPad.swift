//
//  ScreenPad.swift
//  GameCube
//
//  Created by Michał.Krupa on 08.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SpriteKit

protocol ScreenPadDelegate {
    func right(padInclination:CGVector)
}

class ScreenPad: SKScene {
    
    
    /*********************************************************************************
     Klasa do obsługi akcji w grze, wyswietlająca aktualne informacje oraz kontrolery
     TODO: Dodanie obsługi drugiego palucha akcji
     *********************************************************************************/
    
    public var padDelegate:ScreenPadDelegate?
    
    static let joyBackA:CGFloat = 165
    private let gestureRecog    = UIGestureRecognizer()
    private let joystickR       = SKSpriteNode(imageNamed: "joystick")
    private let joyBackR        = SKSpriteNode(imageNamed: "joyBack")
    private var joyCenterR      = CGPoint(x: 300, y: 200)
    private var grabRight       = false
    private var activRight      = false
    private let joySize         = CGSize(width: 50, height: 50)
    private let joyBackSize     = CGSize(width: joyBackA, height: joyBackA)
    
    public let maxIncPoint:CGFloat
    public var padInclination       = CGVector(dx: 0, dy: 0)
    public var padPercInclination   = CGVector(dx: 0, dy: 0)
    
    override init() {
        maxIncPoint = (joyBackSize.width/2.0 - joySize.width/4.0)
        super.init()
    }
    
    override init(size: CGSize) {
    
        maxIncPoint = (joyBackSize.width/2.0 - joySize.width/4.0)
        
        super.init(size: size)
        
        joyCenterR          = CGPoint(x: size.width - joyBackSize.width*0.6, y: joyBackSize.width*0.6)
        joystickR.position  = joyCenterR
        joystickR.size      = joySize
        joyBackR.position   = joyCenterR
        joyBackR.size       = joyBackSize
        
        self.addChild(joyBackR)
        self.addChild(joystickR)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     Funkcja sprawdza czy złapaliśmy przycisk przy dotknięciu
     */
    private func didGrab(joystick:SKSpriteNode, atPosition pos:CGPoint) -> Bool {
        if  (pos.x < joystick.position.x + joySize.width/2.0 && pos.x > joystick.position.x - joySize.width/2.0) &&
            (pos.y < joystick.position.y + joySize.width/2.0 && pos.y > joystick.position.y - joySize.width/2.0) {
            return true
        }
        return false
    }
    
    
    /**
     Funkcja zwracająca odwrócony dotyk względem osi y w scenie SpriteKite
     */
    private func getReverse(array:[CGPoint]) -> [CGPoint] {
        var newArr = Array<CGPoint>()
        for touch in array {
            var new = touch
            new.y = (self.view?.frame.size.height)! - new.y
            newArr.append(new)
        }
        return newArr
    }
    
    
    /**
     Funkcja zwracająca pozycję dla danego joystica oraz korygująca go w razie zbytniego wychylenia
     */
    func calculate(position:CGPoint, forJoystick joy:SKSpriteNode) -> CGPoint {
        
        let xPositive   = position.x > joyCenterR.x ? true : false
        let yPositive   = position.y > joyCenterR.y ? true : false
        let x           = abs(joyCenterR.x - position.x)
        let y           = abs(joyCenterR.y - position.y)
        
        let c           = sqrt(pow(x, 2.0) + pow(y, 2.0))
        
        if c <= maxIncPoint {
            activRight = false
            return position
            
        } else {
            activRight  = true
            let prop    = maxIncPoint/c
            let newX    = joyCenterR.x + (x * (xPositive ? 1 : -1)) * prop
            let newY    = joyCenterR.y + (y * (yPositive ? 1 : -1)) * prop
            
            return CGPoint(x: newX, y: newY)
        }
    }
    
    /**
     Funckja oblicza wychylenie dżojstika na dwuwymiarowej powierzchni w punktach
     */
    private func calcInclination() {
        padInclination      = CGVector(dx: Double(joystickR.position.x - joyCenterR.x), dy: Double(joystickR.position.y - joyCenterR.y))
        padPercInclination  = CGVector(dx: padInclination.dx/maxIncPoint, dy: padInclination.dy/maxIncPoint)
        
        padDelegate?.right(padInclination: padPercInclination)
    }
}

extension ScreenPad: UIGestureRecognizerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchArr = getReverse(array: touches.map({ return $0.location(in: self.view) }))
        
        for touch in touchArr {
            if !grabRight {
                grabRight = didGrab(joystick: joystickR, atPosition: touch)
                calcInclination()
            }
        } 
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchArr = getReverse(array: touches.map({ return $0.location(in: self.view) }))
        
        if grabRight {
            joystickR.position = calculate(position: touchArr.first!, forJoystick: joystickR)
            calcInclination()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if grabRight {
            grabRight           = false
            activRight          = false
            joystickR.position  = joyCenterR
            calcInclination()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
