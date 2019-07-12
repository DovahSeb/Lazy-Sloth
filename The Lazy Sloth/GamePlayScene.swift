//
//  GamePlayScene.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 03/07/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class GamePlayScene: SKScene, SKPhysicsContactDelegate{
    
    //Declare sprite variables
    var background = SKSpriteNode()
    var home = SKSpriteNode()
    var pause = SKSpriteNode()
    var apple = SKSpriteNode()
    var heart = SKSpriteNode()
    var appleCollected = SKSpriteNode()
    var gameOverHome = SKSpriteNode()
    var gameOverRestart = SKSpriteNode()
    
    //Declare label and int variables
    var scoreLbl = SKLabelNode()
    var score = 0
    var appleLbl = SKLabelNode()
    var appleNum = Int()
    var health = 2
    var gameOverText = SKLabelNode()
    var gameOverScore = SKLabelNode()
    var gameOverApple = SKLabelNode()

    //Panda
    var panda = SKSpriteNode()
    var pandaWalkingFrames: [SKTexture] = []
    
    //Koala
    var koala = SKSpriteNode()
    var koalaWalkingFrames: [SKTexture] = []

    //Snake
    var snake = SKSpriteNode()
    var snakeWalkingFrames: [SKTexture] = []
    
    //required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //init function
    override init(size: CGSize){
        super.init(size: size)
        
        //call scene function
        //createScene()
        
        //call background function
        createBackground()
        
        //call home button
        createHomeButton()
        
        //call pause button
        createPauseButton()
        
        //call heart function
        createHeart()
        
        //call apple collected function
        createAppleCollected()
        
        //call sscore label
        createScoreLabel()
        
        //call apple label
        createAppleLabel()
        
        //call koala function
        //createKoala()
        
        createPanda()
        
        //continuous apple spawn function
        func appleSpawn(){
            let wait = SKAction.wait(forDuration: 5.0)
            let spawn = SKAction.run(createApple)
            let sequence = SKAction.sequence([wait, spawn])
            run(SKAction.repeatForever(sequence))
        }; appleSpawn()
        
        //continuous snake spawn function
        func snakeSpawn(){
            let wait = SKAction.wait(forDuration: 4.0)
            let spawn = SKAction.run(buildSnake)
            let sequence = SKAction.sequence([wait, spawn])
            run(SKAction.repeatForever(sequence))
        }; snakeSpawn();
    }
    
    override func didMove(to view: SKView) {
        createScene()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for _ in touches{
            panda.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 150.0))
            panda.isPaused = true
            //koala.texture = SKTexture(imageNamed: "koala_jump")
        }
        
        if let touch = touches.first{
            
            if home.contains(touch.location(in: self)){
                home.setScale(1.2)
                removeAllActions()
                removeAllChildren()
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }

            if pause.contains(touch.location(in: self)){
                pause.setScale(1.2)
                if self.isPaused == false{
                    self.isPaused = true
                    pause.texture = SKTexture(imageNamed: "play")
                } else {
                    self.isPaused = false
                    pause.setScale(1.0)
                    pause.texture = SKTexture(imageNamed: "pause")
                }
            }
            if gameOverHome.contains(touch.location(in: self)){
                gameOverHome.setScale(1.2)
                removeAllActions()
                removeAllChildren()
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if gameOverRestart.contains(touch.location(in: self)){
                gameOverRestart.setScale(1.2)
                let scene = GamePlayScene(size: self.size)
                self.view?.presentScene(scene)
                restartScene()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for _ in touches{
            panda.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: -500.0))
            panda.isPaused = false
        }
        
        if let touch = touches.first{
            
            if home.contains(touch.location(in: self)){
                home.setScale(1.0)
            }
            if pause.contains(touch.location(in: self)){
                pause.setScale(1.0)
            }
            if gameOverHome.contains(touch.location(in: self)){
                gameOverHome.setScale(1.0)
            }
            if gameOverRestart.contains(touch.location(in: self)){
                gameOverRestart.setScale(1.0)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //Define two bodies for collision
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.pandaCategory && secondBody.categoryBitMask == CollisionBitMask.snakeCategory{
            print("contact")
            
            //Remove one heart after one bite
            let childheart = self.childNode(withName: "heart") as? SKSpriteNode
            childheart?.removeFromParent()
            
            //death conditions
            if health > 0{
                health -= 1
            }
            else if health == 0{
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                gameOver()
            }
        }
        
        if firstBody.categoryBitMask == CollisionBitMask.pandaCategory && secondBody.categoryBitMask == CollisionBitMask.appleCategory{
            print("ate")
            self.appleNum += 1
            self.appleLbl.text = "x" + "\(self.appleNum)"
            contact.bodyB.node?.removeFromParent()
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //this ensures that your backgrounds line up perfectly
        
    }
    
}
