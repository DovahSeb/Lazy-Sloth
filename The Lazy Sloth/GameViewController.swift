//
//  GameViewController.swift
//  The Lazy Sloth
//
//  Created by Sebastien Larue on 26/02/2019.
//  Copyright © 2019 KangaGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let mainScene = MainMenuScene(size: view.bounds.size)
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = false
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        mainScene.scaleMode = .resizeFill
        skView.presentScene(mainScene)
        
        }
    }

     //Disable autorotate
    var shouldAutorotate: Bool {
        return false
    }

    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    //Hide status bar
    var prefersStatusBarHidden: Bool {
        return true
    }




