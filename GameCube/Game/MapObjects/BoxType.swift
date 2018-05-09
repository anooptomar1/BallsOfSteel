//
//  BoxType.swift
//  GameCube
//
//  Created by Michał.Krupa on 27.03.2018.
//  Copyright © 2018 Michał.Krupa. All rights reserved.
//

import UIKit


/****************************************************************
 
 Protokół do opisywania Boxów wykorzystywanych w grze
 TODO:Będa prawdopodobnie rozwijane pola
 
 ***************************************************************/

protocol BoxType {
    
    static var nameFrag:String           {get} 
    static var path:String               {get}
    static var width:CGFloat             {get}
    static var lenght:CGFloat            {get}
    static var height:CGFloat            {get}
    static var verticalBumperH:CGFloat   {get}
    static var horizontalBumperW:CGFloat {get}
    // static var type - do opisu konkretnej grafiki
    
}
