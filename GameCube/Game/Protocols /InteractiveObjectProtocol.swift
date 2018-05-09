//
//  InteractiveObjectProtocol.swift
//  GameCube
//
//  Created by Michał.Krupa on 19.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit


/**************************************************************************************************
 Protokol ktory będzie implementowany przez kazdy obiekt ktory bedzie sie ruszac lub wplywac na gre
 Moga to byc paczki z lekarstwami lub przeciwnicy
 **************************************************************************************************/

protocol InteractiveObjectProtocol  {
    
    var tasks:Array<String> { get set } // TODO: tmp 'String' - docelowo ma byc to klasa task
    func update()
    
}

enum ObjectType: UInt8 {
    
    case PlayerBox              = 1
    case LCollisonBox           = 2
    case RCollisonBox           = 4
    case TCollisonBox           = 8
    case BCollisonBox           = 16
    case PlayerCollisionBoxes   = 30
    case ObstacleBox            = 32
    
}


/****************************
 Boxy dla wszystkich obiektów
 ****************************/

enum CollisionBoxes:UInt8 {
    
    /**
     Boxy Dla playera
     */
    case PNorthBox   = 1
    case PEastBox    = 2
    case PSouthBox   = 4
    case PWestBox    = 8
    case PTopBox     = 16
    case PBottomBox  = 32
    
    /**
     TODO: Boxy dla pozostalych przeciwnikow oraz obiektow aktywnych
     */
    
}
