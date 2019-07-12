//
//  MainMenuScene.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 09/03/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    //Declare variables
    var background = SKSpriteNode()
    var title = SKSpriteNode()
    var play2 = SKSpriteNode()
    var play = SKLabelNode()
    var highscore2 = SKSpriteNode()
    var highScore = SKLabelNode()
    
    
    // required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //init function
    override init(size: CGSize){
        super.init(size: size)
        
        //call background function
        createBackground()
        
        //call title function
        createTitle()
        
        //call play function
        createPlayButton()
        
        //call highscore function
        createHighScoreButton()
        
    }
    
    override func didMove(to view: SKView) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            
            if play.contains(touch.location(in: self)){
                play.setScale(1.2)
                let scene = GamePlayScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if highScore.contains(touch.location(in: self)){
                highScore.setScale(1.2)
                let scene = HighScoreScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            
            if play.contains(touch.location(in: self)){
                play.setScale(1.0)
            }
            
            if highScore.contains(touch.location(in: self)){
                highScore.setScale(1.0)
            }
        }
    }
    
    
    
    
    
    
    
}



