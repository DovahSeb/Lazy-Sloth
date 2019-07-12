//
//  HighScoreElements.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 03/07/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension HighScoreScene{
    
    //create background image
    func createBackground(){
        background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.zPosition = 1
        self.addChild(background)
    }
    
    //create home button
    func createHomeButton(){
        home = SKSpriteNode(imageNamed: "home")
        home.position = CGPoint(x: self.frame.width/3, y: self.frame.height/6)
        home.size = CGSize(width: 50, height: 50)
        home.zPosition = 4
        self.addChild(home)
    }
    
    //create share button
    func createShareButton(){
        share = SKSpriteNode(imageNamed: "share")
        share.position = CGPoint(x: self.frame.width/1.5, y: self.frame.height/6)
        share.size = CGSize(width: 50, height: 50)
        share.zPosition = 4
        self.addChild(share)
    }
    
    //create the score label
    func createHighScoreLabel(){
        highScoreLabel = SKLabelNode()
        highScoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height * 0.6)
        let defaults = UserDefaults.standard
        if let highestScore = defaults.object(forKey: "highestScore"){
            //highScoreLabel.text = "High Score:\(highestScore)"
            highScoreLabel.text = NSLocalizedString("highscore", comment: "") + "\(highestScore)"
        } else {
            highScoreLabel.text = "High Score: 0"
        }
        highScoreLabel.zPosition = 2
        highScoreLabel.fontSize = 22
        highScoreLabel.fontName = "AnuDaw"
        highScoreLabel.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        self.addChild(highScoreLabel)
    }
    
    //create score comment
    func createScoreComment(){
        scoreComment = SKLabelNode()
        scoreComment.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.width/1.1)
        //scoreComment.text = "Play The Game"
        scoreComment.zPosition = 2
        scoreComment.fontSize = 20
        scoreComment.fontName = "AnuDaw"
        scoreComment.fontColor = UIColor(displayP3Red: 154/255, green: 103/255, blue: 26/255, alpha: 1.0)
        scoreComment.childNode(withName: "comment")
        let defaults = UserDefaults.standard
        let highestScore = defaults.integer(forKey: "highestScore")
        switch highestScore {
        case 0:
            scoreComment.text = NSLocalizedString("playgame", comment: "")
            break
        case 1..<500:
            scoreComment.text = NSLocalizedString("panda", comment: "")
            break
        case 500..<2500:
            scoreComment.text = NSLocalizedString("goat", comment: "")
            break
        case 2500..<5000:
            scoreComment.text = NSLocalizedString("deer", comment: "")
            break
        default:
            break
        }
        self.addChild(scoreComment)
    }
    
    //create reset score
    func createResetScore(){
        resetScore = SKLabelNode()
        resetScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height/11)
        resetScore.text = "Reset Score"
        resetScore.zPosition = 2
        resetScore.fontSize = 14
        resetScore.fontName = "AnuDaw"
        self.addChild(resetScore)
    }
    
}
