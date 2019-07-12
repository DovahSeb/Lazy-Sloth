//
//  MainMenuElements.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 09/03/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
//Color code 
//#9A671A

extension MainMenuScene{
    
    //add background
    func createBackground(){
        background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint(x: 0, y: -170)
        background.zPosition = 1
        self.addChild(background)
        
    }
    
    //add title
    func createTitle(){
        title = SKSpriteNode(imageNamed: "title")
        title.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.8)
        title.size = CGSize(width: 400, height: 400)
        title.zPosition = 2
        self.addChild(title)
    }
    
    //add play button
    func createPlayButton(){
        play = SKLabelNode()
        play.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        play.text = NSLocalizedString("play", comment: "")
        play.fontSize = 30
        play.fontName = "AnuDaw"
        play.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        play.zPosition = 2
        self.addChild(play)
    }
    
    //add highdcore button
    func createHighScoreButton(){
        highScore = SKLabelNode()
        highScore.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2.5)
        highScore.text = NSLocalizedString("score", comment: "")
        highScore.fontSize = 30
        highScore.fontName = "AnuDaw"
        highScore.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        highScore.zPosition = 2
        self.addChild(highScore)
    }
    
}
