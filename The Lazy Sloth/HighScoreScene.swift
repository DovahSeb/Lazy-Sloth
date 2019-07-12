//
//  HighScoreScene.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 03/07/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

extension UIView {
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer{
            UIGraphicsEndImageContext()
        }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

class HighScoreScene: SKScene {
    
    //Declare sprite variables
    var background = SKSpriteNode()
    var home = SKSpriteNode()
    var share = SKSpriteNode()
    
    //Declare label variables
    var highScoreLabel = SKLabelNode()
    var scoreComment = SKLabelNode()
    var shareButton = SKSpriteNode()
    var resetScore = SKLabelNode()
    
    // required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        //call background image
        createBackground()
        
        //call home button function
        createHomeButton()
        
        //call share button function
        createShareButton()
        
        //call high score label
        createHighScoreLabel()
        
        //call score comment function
        createScoreComment()
        
        //call score comment function
        createScoreComment()
        
    }
    
    override func didMove(to view: SKView) {
        
        //call reset score function
        createResetScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            
            if home.contains(touch.location(in: self)){
                home.setScale(1.2)
                let scene = MainMenuScene(size: self.size)
                let reveal = SKTransition.reveal(with: .down, duration: 1.0)
                self.view?.presentScene(scene, transition: reveal)
            }
            
            if share.contains(touch.location(in: self)){
                //share.setScale(1.2)
                if var top = scene?.view?.window?.rootViewController{
                    while let presentedViewController = top.presentedViewController{
                        top = presentedViewController
                    }
                    let defaults = UserDefaults.standard
                    let highestScore = defaults.integer(forKey: "highestScore")
                    var comment = String()
                    switch highestScore {
                    case 0:
                        comment = NSLocalizedString("playgame", comment: "")
                        break
                    case 1..<500:
                        comment = NSLocalizedString("panda", comment: "")
                        break
                    case 500..<2500:
                        comment = NSLocalizedString("goat", comment: "")
                        break
                    case 2500..<5000:
                        comment = NSLocalizedString("deer", comment: "")
                        break
                    default:
                        break
                    }
                    let postText: String = "\(comment). " + NSLocalizedString("sharemessage", comment: "") + "\(highestScore)? #LazySloth"
                    let postImage: UIImage = getScreenshot(scene: scene!)
                    let activityVC = UIActivityViewController(activityItems: [postText, postImage], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = view
                    top.present(activityVC, animated: true, completion: nil)
                }
            }
            
            if resetScore.contains(touch.location(in: self)){
                resetScore.setScale(1.1)
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "highestScore")
                defaults.set(0, forKey: "highestScore")
                defaults.synchronize()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            
            if home.contains(touch.location(in: self)){
                home.setScale(1.0)
            }
            
            if share.contains(touch.location(in: self)){
                //share.setScale(1.0)
            }
            
            if resetScore.contains(touch.location(in: self)){
                resetScore.setScale(1.0)
            }
        }
    }
    
    //Takes the screenshot
    func getScreenshot(scene: SKScene) -> UIImage {
        let myImage = view?.snapshot
        return myImage!;
    }
    
}
