//
//  ViewController.swift
//  DemoGameFish
//
//  Created by Chung on 8/29/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameManager: GameManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
      self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapHandle:")))
        NSTimer.scheduledTimerWithTimeInterval(0.025, target: self.gameManager!, selector: Selector("updateMove"), userInfo: nil, repeats: true)
    }
    func tapHandle(sender: UIGestureRecognizer){
        let tapPoint = sender.locationInView(self.view)
        self.gameManager?.dropHookAtX(Int(tapPoint.x))
    }

    @IBAction func reset(sender: UIButton) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews{
            if object.isKindOfClass(Fish) {
                object.removeFromSuperview()
            }
        }
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
    }

    @IBAction func addFish(sender: UIButton) {
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))

    }
}

