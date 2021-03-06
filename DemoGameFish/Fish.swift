//
//  Fish.swift
//  DemoGameFish
//
//  Created by Chung on 8/29/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import Foundation
import UIKit

class Fish: UIImageView {
    var status: Int?
    var speed: Int?
    var vy: Int?
    var widthFrame: Int?
    var heightFrame: Int?
    var widthFish: Int?
    var heightFish: Int?
    
    let MOVING: Int = 0
    let CAUGHT: Int = 1
    
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func generateFish(width: Int){
        self.widthFrame = width
        self.vy = Int(arc4random_uniform(3)) - 1
        let y: Float = Float(arc4random_uniform(240)) + 160
        self.status = MOVING
        self.speed = Int(arc4random_uniform(5) + 2)
        
        if (Int(self.center.x)  <= -Int(self.widthFish!/2)) {
            self.transform = CGAffineTransformIdentity
            self.image = UIImage(named: "fish1")
            self.frame = CGRectMake(-CGFloat(self.widthFish!), CGFloat(y), CGFloat(self.widthFish!), CGFloat(self.heightFish!))
        }else{
            
            self.transform = CGAffineTransformIdentity
            self.image = UIImage(CGImage: (UIImage(named: "fish1")?.CGImage!)!, scale: 1.0, orientation: UIImageOrientation.UpMirrored)
            self.frame = CGRectMake(CGFloat(self.widthFrame! + self.widthFish!/2), CGFloat(y), CGFloat(self.widthFish!), CGFloat(self.heightFish!))
            
            self.speed = -Int(self.speed!)
        }
    }
    
    
    func updateMove(){
        
        if self.status == MOVING {
        
            self.center = CGPointMake(self.center.x + CGFloat(self.speed!), self.center.y + CGFloat(self.vy!))
            if ((Int(self.center.y)) < self.widthFish || (Int(self.center.y)) > self.widthFrame) {
                self.vy = -self.vy!
            }
            if ((Int(self.center.x)) > self.widthFrame! && self.speed! > 0 ||
                (Int(self.center.x)) < -self.widthFish! && self.speed! < 0)
            {
                generateFish(self.widthFrame!)
            }
        
        }else if( self.status == CAUGHT){
            self.center = CGPointMake(self.center.x, self.center.y - 5)
            
            if (Int(self.center.y) < self.widthFish) {
                generateFish(self.widthFrame!)
            }
        }
    }
    
    func caught(){
        
        if self.status == MOVING {
            self.status = CAUGHT
            if self.speed > 0 {
                self.transform = CGAffineTransformMakeRotation(CGFloat(-M_2_PI))
            }
            else{
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_2_PI))

            }
        }
    }
    
}
