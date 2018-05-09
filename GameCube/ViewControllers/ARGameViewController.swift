//
//  ARGameViewController.swift
//  GameCube
//
//  Created by Michał.Krupa on 22.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ARGameViewController: UIViewController {
    
    @IBOutlet weak var scnView: ARSCNView!
   
    var configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        
        GameManager.shared.currLevel.hud.size   = self.view.frame.size
        let configuration = ARWorldTrackingConfiguration()
        scnView.session.run(configuration)
        
        scnView.scene                           = GameManager.shared.currLevel.scene
        scnView.overlaySKScene                  = GameManager.shared.currLevel.hud
        scnView.antialiasingMode                = .multisampling4X
        scnView.delegate                        = self
        scnView.loops                           = true
        scnView.isPlaying                       = true
        scnView.showsStatistics                 = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
}

extension ARGameViewController: ARSCNViewDelegate {
    
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
            TimeMachine.shared.oldTime = time
        }
    }
    
    
}
