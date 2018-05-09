//
//  SkewManager.swift
//  GameCube
//
//  Created by Michał.Krupa on 20.02.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit
import CoreMotion

protocol SkewManagerDelegate {
    
}


/**
 Klasa odpowiedzialna za odbieranie informacji o przechyleniu telefonu
 */
class SkewManager: NSObject {
    
    
    static let shared = SkewManager()
    
    var motionManager:CMMotionManager = CMMotionManager()
    var isScanning:Bool = false
    var skewX:Double?
    var skewY:Double?
    var skewZ:Double?
    var delegate:SkewManagerDelegate?
    
    override init() {
        skewX = 0
        skewY = 0
        skewZ = 0
    }
    
    /**
     Metoda do odbioru i zapisu pól przechyłu. Obecnie obsluguje tylko pionową orientacje telefonu
     TODO: obsługa innych ułożeń urządzenia
     */
    func startScanning() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue.init(), withHandler: { (data:CMDeviceMotion?, NSError) -> Void in
            
            self.skewX = data?.attitude.roll  // na boczki
            self.skewY = data?.attitude.yaw   // koleczko
            self.skewZ = data?.attitude.pitch // przód i tyl
            
        })
    }
    
    func stopScanning() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func getCurrPitch() -> Double{
        
        if let pitch =  motionManager.deviceMotion?.attitude.pitch {
            return pitch
        }
        return 0
    
    }
    
    /**
     Zmiana stanu skanowania na odwrotny
     */
    func changeScanState() {
        isScanning = !isScanning
        if !isScanning {
            stopScanning()
        } else {
            startScanning()
        }
    }
    
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
