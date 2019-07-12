//
//  GamePlayElements.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 03/07/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

//Declare bitmasks
struct CollisionBitMask{
    static let pandaCategory:UInt32 = 0x1 << 0
    static let appleCategory:UInt32 = 0x1 << 1
    static let snakeCategory:UInt32 = 0x1 << 2
    static let sceneCategory: UInt32 = 0x1 << 3
}

extension GamePlayScene{
    
    //scene creator
    func createScene(){
        //Add physics to the scene
        self.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: self.frame.size.height/5), to: CGPoint(x: self.frame.size.width, y: self.frame.size.height/5))
        self.physicsBody?.restitution = 0.0
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.speed = 1.0
    }
    
    //add background
    func createBackground(){
        let backgroundTexture = SKTexture(imageNamed: "background")
        
        for i in 0 ... 1 {
            background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: -170)
            self.addChild(background)
            
            //background animation
            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 15)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            background.run(moveForever)
        }
    }
    
    //home button
    func createHomeButton(){
        home = SKSpriteNode(imageNamed: "home")
        home.position = CGPoint(x: frame.size.width * 0.75, y: frame.size.height * 0.95)
        home.size = CGSize(width: 35, height: 35)
        home.zPosition = 4
        self.addChild(home)
    }
    
    //pause button
    func createPauseButton(){
        pause = SKSpriteNode(imageNamed: "pause")
        pause.position = CGPoint(x: frame.size.width * 0.88, y: frame.size.height * 0.95)
        pause.size = CGSize(width: 35, height: 35)
        pause.zPosition = 4
        self.addChild(pause)
    }
    
    //Create life/hearts
    func createHeart(){
        let numhearts = 3
        var paddingRow = 0
        for _ in 0..<numhearts{
            let heartTexture = SKTexture(imageNamed: "heart")
            heart = SKSpriteNode(texture: heartTexture)
            heart.position = CGPoint(x: self.frame.width/9.6 + CGFloat(paddingRow), y: self.frame.height * 0.945)
            heart.size = CGSize(width: 35, height: 35)
            heart.zPosition = 10
            heart.name = "heart"
            paddingRow = paddingRow + 30
            self.addChild(heart)
        }
    }
    
    //apple sprite
    func createApple(){
        apple = SKSpriteNode(imageNamed: "apple")
        apple.size = CGSize(width: 50, height: 50)
        apple.zPosition = 2
        //random spawn
        let actualY = random(min: size.height/4, max: size.height/2)
        apple.position = CGPoint(x: size.width + size.width/2 , y: actualY )
        //sprite movement
        let actionMove = SKAction.move(to: CGPoint(x: -apple.size.width , y: actualY),
                                       duration: TimeInterval(3.0))
        let actionMoveDone = SKAction.removeFromParent()
        apple.run(SKAction.sequence([actionMove, actionMoveDone]))
        //Add physics to apple
        apple.physicsBody = SKPhysicsBody(circleOfRadius: max(apple.size.width/4,
                                                              apple.size.height/4))
        apple.physicsBody?.isDynamic = true
        apple.physicsBody?.affectedByGravity = false
        apple.physicsBody?.categoryBitMask = CollisionBitMask.appleCategory
        apple.physicsBody?.collisionBitMask = 0
        apple.physicsBody?.contactTestBitMask = CollisionBitMask.pandaCategory
        
        apple.name = "apple"
        self.addChild(apple)
    }
    
    //apple collected sprite
    func createAppleCollected(){
        appleCollected = SKSpriteNode(imageNamed: "apple")
        appleCollected.size = CGSize(width: 40, height: 40)
        appleCollected.position = CGPoint(x: self.frame.width/9.6, y: self.frame.height * 0.9)
        appleCollected.zPosition = 2
        self.addChild(appleCollected)
    }
    
    //create panda sprite
    func createPanda(){
        let pandaAnimatedAtlas = SKTextureAtlas(named: "panda_walk")
        var walkFrames: [SKTexture] = []
        
        let numImages = pandaAnimatedAtlas.textureNames.count
        for i in 1...numImages{
            let pandaTextureName = "panda_walk\(i)"
            walkFrames.append(pandaAnimatedAtlas.textureNamed(pandaTextureName))
        }
        
        //configure panda sprite
        pandaWalkingFrames = walkFrames
        let firstFrameTexture = pandaWalkingFrames[0]
        panda = SKSpriteNode(texture: firstFrameTexture)
        panda.position = CGPoint(x: self.size.width/4, y: self.frame.size.height/4)
        panda.size = CGSize(width: 70, height: 65)
        panda.zPosition = 2
        
        //animate the panda
        let pandaAnimation = (SKAction.repeatForever(SKAction.animate(with: pandaWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
        panda.run(pandaAnimation, withKey: "walkingPanda")
        
        //add collision to the panda sprite
        panda.physicsBody = SKPhysicsBody(circleOfRadius: max(panda.size.width/3, panda.size.height/2))
        //koala.physicsBody = SKPhysicsBody(texture: koala.texture!, size: CGSize(width: 50, height: 70))
        panda.physicsBody?.isDynamic = true
        panda.physicsBody?.affectedByGravity = true
        panda.physicsBody?.allowsRotation = false
        panda.physicsBody?.mass = 1.0
        panda.physicsBody?.restitution = 0.0
        panda.physicsBody?.categoryBitMask = CollisionBitMask.pandaCategory
        panda.physicsBody?.collisionBitMask = 1
        panda.physicsBody?.contactTestBitMask = CollisionBitMask.snakeCategory | CollisionBitMask.appleCategory
        
        //add sprite to the scene
        self.addChild(panda)
    }
    
    //create koala sprite
    /*func createKoala(){
        let koalaAnimatedAtlas = SKTextureAtlas(named: "koala")
        var walkFrames: [SKTexture] = []
        
        let numImages = koalaAnimatedAtlas.textureNames.count
        for i in 1...numImages{
            let koalaTextureName = "koala\(i)"
            walkFrames.append(koalaAnimatedAtlas.textureNamed(koalaTextureName))
        }
        
        //configure koala sprite
        koalaWalkingFrames = walkFrames
        let firstFrameTexture = koalaWalkingFrames[0]
        koala = SKSpriteNode(texture: firstFrameTexture)
        koala.position = CGPoint(x: self.size.width/4, y: self.frame.size.height/4)
        koala.size = CGSize(width: 50, height: 70)
        koala.zPosition = 2
        
        //animate the koalo
        let koalaAnimation = (SKAction.repeatForever(SKAction.animate(with: koalaWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
        koala.run(koalaAnimation, withKey: "walkingKoala")
        
        //add collision to the koala sprite
        koala.physicsBody = SKPhysicsBody(circleOfRadius: max(koala.size.width/3, koala.size.height/2))
        //koala.physicsBody = SKPhysicsBody(texture: koala.texture!, size: CGSize(width: 50, height: 70))
        koala.physicsBody?.isDynamic = true
        koala.physicsBody?.affectedByGravity = true
        koala.physicsBody?.allowsRotation = false 
        koala.physicsBody?.mass = 1.0
        koala.physicsBody?.restitution = 0.0
        koala.physicsBody?.categoryBitMask = CollisionBitMask.koalaCategory
        koala.physicsBody?.collisionBitMask = 1
        koala.physicsBody?.contactTestBitMask = CollisionBitMask.snakeCategory | CollisionBitMask.appleCategory
        
        //add sprite to the scene
        self.addChild(koala)
    }*/
    
    //create snake sprite
    func buildSnake(){
        let snakeAnimatedAtlas = SKTextureAtlas(named: "snake")
        var walkFrames: [SKTexture] = []
        
        let numImages = snakeAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let snakeTextureName = "snake\(i)"
            walkFrames.append(snakeAnimatedAtlas.textureNamed(snakeTextureName))
        }
        
        //configure snake sprite
        snakeWalkingFrames = walkFrames
        let firstFrameTexture = snakeWalkingFrames[0]
        snake = SKSpriteNode(texture: firstFrameTexture)
        snake.position = CGPoint(x: size.width + size.width/2, y: self.frame.size.height/4.4)
        snake.size = CGSize(width: 70, height: 50)
        snake.zPosition = 3
        
        //animate the snake
        let snakeAnimation = (SKAction.repeatForever(SKAction.animate(with: snakeWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)))
        
        //make the snake move from left to right
        let actionMove = SKAction.move(to: CGPoint(x: -snake.size.width , y: self.frame.size.height/4),
                                           duration: TimeInterval(4.0))
        
        //add sequence snake move then remove
        let moveAndRemoveSequence = SKAction.sequence([actionMove, SKAction.removeFromParent()])
        
        //groupe snake animation with movement
        let wholeAction = SKAction.group([snakeAnimation, moveAndRemoveSequence])
        
        //run the action
        snake.run(wholeAction, withKey: "walkingInPlaceSnake")
        
        //add collision to snake sprite
        snake.physicsBody = SKPhysicsBody(circleOfRadius: max(snake.size.width/3, snake.size.height/3))
        //snake.physicsBody = SKPhysicsBody(texture: snake.texture!, size: CGSize(width: 70, height: 50))
        snake.physicsBody?.isDynamic = true
        snake.physicsBody?.affectedByGravity = false
        snake.physicsBody?.allowsRotation = false
        snake.physicsBody?.restitution = 0.0
        snake.physicsBody?.categoryBitMask = CollisionBitMask.snakeCategory
        snake.physicsBody?.collisionBitMask = 1
        snake.physicsBody?.contactTestBitMask = CollisionBitMask.pandaCategory
        
        //add sprite to the scene
        self.addChild(snake)
    }
    
    //score label
    func createScoreLabel(){
        scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.93)
        scoreLbl.text = "Score:0"
        scoreLbl.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        scoreLbl.zPosition = 4
        scoreLbl.fontSize = 22
        scoreLbl.fontName = "AnuDaw"
        self.addChild(scoreLbl)
        let delay = SKAction.wait(forDuration: 0.5)
        let incrementScore = SKAction.run ({
            self.score += 1
            self.scoreLbl.text = "Score:" + "\(self.score)"
        })
        scoreLbl.run(SKAction.repeatForever(SKAction.sequence([delay,incrementScore])), withKey: "scoreCounter")
    }
    
    //apple collected label
    func createAppleLabel(){
        appleLbl = SKLabelNode()
        appleLbl.position = CGPoint(x: self.frame.width/4.9, y: self.frame.height * 0.885)
        appleLbl.text = "x0"
        appleLbl.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        appleLbl.zPosition = 2
        appleLbl.fontSize = 22
        appleLbl.fontName = "AnuDaw"
        self.addChild(appleLbl)
    }
    
    //game over text
    func createGameOverText(){
        gameOverText = SKLabelNode()
        gameOverText.position = CGPoint(x: self.frame.width/2, y: self.frame.height + 10)
        gameOverText.text = "Game Over"
        gameOverText.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        gameOverText.zPosition = 3
        gameOverText.fontSize = 30
        gameOverText.fontName = "AnuDaw"
        let moveText = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height * 0.8), duration: 1.0)
        gameOverText.run(moveText)
        self.addChild(gameOverText)
    }
    
    //game over score label
    func createGameOverScore(){
        gameOverScore = SKLabelNode()
        gameOverScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        if appleNum == 0{
            gameOverScore.text = "Final Score \(score)"
        } else {
            gameOverScore.text = "Final Score \(score * appleNum)"
        }
        gameOverScore.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        gameOverScore.zPosition = 3
        gameOverScore.fontSize = 20
        gameOverScore.fontName = "AnuDaw"
        let moveScore = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height * 0.7), duration: 1.0)
        gameOverScore.run(moveScore)
        self.addChild(gameOverScore)
    }
    
    //game over star label
    func createGameOverApple(){
        gameOverApple = SKLabelNode()
        gameOverApple.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        gameOverApple.text = "Apples x\(appleNum)"
        gameOverApple.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        gameOverApple.zPosition = 3
        gameOverApple.fontSize = 20
        gameOverApple.fontName = "AnuDaw"
        let moveScore = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height * 0.65), duration: 1.0)
        gameOverApple.run(moveScore)
        self.addChild(gameOverApple)
    }
    
    //game over home
    func createGameOverHome(){
        gameOverHome = SKSpriteNode(imageNamed: "home")
        gameOverHome.size = CGSize(width: 50, height: 50)
        gameOverHome.position = CGPoint(x: self.frame.width/3, y: self.frame.height/2)
        gameOverHome.zPosition = 3
        self.addChild(gameOverHome)
    }
    
    //game over restart
    func createGameOverRestart(){
        gameOverRestart = SKSpriteNode(imageNamed: "restart")
        gameOverRestart.size = CGSize(width: 50, height: 50)
        gameOverRestart.position = CGPoint(x: self.frame.width * 0.65, y: self.frame.height/2)
        gameOverRestart.zPosition = 3
        self.addChild(gameOverRestart)
    }
    
    //restart a new game
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        score = 0
        appleNum = Int()
        createScene()
    }
    
    //game over function
    func gameOver(){
        
        //call game over labels
        createGameOverText()
        createGameOverScore()
        createGameOverApple()
        
        //call game over sprite
        createGameOverRestart()
        createGameOverHome()
        
        //remove sprites
        home.removeFromParent()
        pause.removeFromParent()
        appleCollected.removeFromParent()
        
        //remove labels
        scoreLbl.removeFromParent()
        appleLbl.removeFromParent()
        
        //remove any actions
        scoreLbl.removeAction(forKey: "scoreCounter")
        
        
        //Save high score as soon as game over
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "highestScore") != nil {
            let hscore = defaults.integer(forKey: "highestScore")
            if hscore < (score * appleNum){
                defaults.set((score * appleNum), forKey: "highestScore")
            }
        } else {
            defaults.set(0, forKey: "highestScore")
        }
    }
    
    //Random number generator
    func random() -> CGFloat {
        return CGFloat(CGFloat(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    //hit animation
    func hitAnimation(){
        //koala.isPaused = true
        //koala.alpha = 0.0
        func hit1(){
            koala.alpha = 0.0
            koala.run(SKAction.fadeOut(withDuration: 1.0))
        }
        func hit2(){
            koala.alpha = 1.0
            koala.run(SKAction.fadeIn(withDuration: 1.0))
        }
        let hitSeq = SKAction.sequence([SKAction.run(hit1), SKAction.wait(forDuration: 2.0), SKAction.run(hit2)])
        SKAction.repeat(hitSeq, count: 1)
    }
}
