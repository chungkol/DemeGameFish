//
//  GameManager.swift
//  DemoGameFish
//
//  Created by Chung on 8/30/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import Foundation
import UIKit

class GameManager: NSObject {
    var fishViews: NSMutableArray?
    var hookView: HookView?
    var total: Int = 0
    var flag: Bool = false
    
    override init() {
        self.fishViews = NSMutableArray()
        self.hookView = HookView(frame: CGRectMake(0, -490, 20, 490))
    }
    
    
    func addFishToViewController(viewController: UIViewController , width: Int) {
        let fishView = Fish(frame: CGRectMake(0, 0, 60, 60))
        fishView.generateFish(width)
        self.fishViews?.addObject(fishView)
        viewController.view.addSubview(fishView)
    }
    
    
    func bite(fishView: Fish){
        if (fishView.status != fishView.CAUGHT
            && self.hookView?.status != self.hookView?.DRAWINGUP) {
            fishView.caught()
            fishView.center = CGPointMake(self.hookView!.center.x,self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
            flag = true
        }
        }
    func updateMove() {
        self.hookView?.updateMove()
        for fishView in self.fishViews!{
            fishView.updateMove()
            if (CGRectContainsPoint(fishView.frame, CGPointMake((self.hookView?.center.x)!,
                (self.hookView?.center.y)! + (self.hookView?.bounds.height)!/2)) && !flag )
            {
                bite(fishView as! Fish)
            }
        }
        if self.hookView?.status == self.hookView?.PREPARE {
            flag = false
        }
    }
    
    func dropHookAtX(x: Int){
        self.hookView?.dropDownAtX(x)
    }


}
