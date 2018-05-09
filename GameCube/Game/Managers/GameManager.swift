//
//  GameManager.swift
//  GameCube
//
//  Created by Michał.Krupa on 19.02.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit

protocol GameManagerDelegate {
    func performFadeOut()
    func performFadeIn()
    func shouldUpdateScenes()
}

class GameManager: NSObject {
    
    var delegate:GameManagerDelegate?
    
    static let shared = GameManager()
    
    var currLevel:GameProtocol = Level()
    
    override init() {
        
    }
    
    public func didFinishCurrentLevel() {
        delegate?.performFadeOut()
    }
    
    public func didFinishFadeOut() {
        
        if ((currLevel as? MainMenu) != nil) {
            
            
            currLevel = Level()
            
            
            delegate?.shouldUpdateScenes()
        }
    }
    
    public func didFinishLoadNewScene() {
        delegate?.performFadeIn()
    }
}

enum GameLevels:Int {
    case Menu = 0
}
