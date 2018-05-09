//
//  MainMenu2D.swift
//  GameCube
//
//  Created by Michał Krupa on 07.05.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SpriteKit

protocol MainMenu2DDelegate {
    func didPickStart()
}

class MainMenu2D: SKScene {

    public var menuDelegate:MainMenu2DDelegate?
    private let gestureRecog = UIGestureRecognizer()
    
    override init() {
        super.init()
        initButtons()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        initButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initButtons() {
        
    }
}

extension MainMenu2D: UIGestureRecognizerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        menuDelegate?.didPickStart()
    }
    
}
