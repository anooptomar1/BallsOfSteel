//
//  GameControllerViewController.swift
//  GameCube
//
//  Created by Michał.Krupa on 19.02.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    
    override func viewDidLoad() {
       
        GameManager.shared.delegate             = self
        GameManager.shared.currLevel.hud.size   = self.view.frame.size
        
        scnView                                 = SCNView(frame: self.view.frame)
        scnView.scene                           = GameManager.shared.currLevel.scene
        scnView.overlaySKScene                  = GameManager.shared.currLevel.hud
        scnView.antialiasingMode                = .multisampling4X
        scnView.delegate                        = self
        scnView.loops                           = true
        scnView.isPlaying                       = true
        scnView.showsStatistics                 = true
        
        self.view.addSubview(scnView)
        
        
    }
     
}

extension GameViewController: GameManagerDelegate {
    func performFadeOut() {
//        UIView.animate(withDuration: 0.3, animations: {
////            self.view.alpha = 0
//        }, completion: { finish in
            GameManager.shared.didFinishFadeOut()
//        })
    }
    
    
    
    func performFadeIn() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.alpha = 1
//    /    }, completion: { finish in
        
//        })
    }
    
    func shouldUpdateScenes() {
        scnView.scene           = GameManager.shared.currLevel.scene
        scnView.overlaySKScene  = GameManager.shared.currLevel.hud
        
        performFadeIn()

    }
    
    
}

extension GameViewController: SCNSceneRendererDelegate {
    
    // Wszystki kroki są uszeregowane po koleji - nie zmieniać
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
        if TimeMachine.shared.oldTime + TimeMachine.shared.interval < time {
            GameManager.shared.currLevel.updateState(atTime: time)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        if TimeMachine.shared.oldTime + TimeMachine.shared.interval < time {
//            GameManager.shared.currLevel.commitAllAnimations()
            TimeMachine.shared.currTime = time
        }
    }
}
