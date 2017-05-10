//
//  ViewController.swift
//  smiley
//
//  Created by Pooja Chowdhary on 5/9/17.
//  Copyright © 2017 Pooja Chowdhary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func onPanGestureRecognizerTray(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let point = panGestureRecognizer.location(in: view)
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        if panGestureRecognizer.state == .began {
            
            print("Gesture began \(point)")
            trayOriginalCenter = trayView.center
            
            
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed \(point)")
            if velocity.y > 0 {
                //down
                trayView.center = trayCenterWhenClosed
            }
            else {
                //up
                trayView.center = trayCenterWhenOpen
            }
         //   trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended \(point)")
        }
        
    }
    
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    var originalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    @IBAction func panGestureMade(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.location(in: view)
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        
        if panGestureRecognizer.state == .began {
            
            let imageView = panGestureRecognizer.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            originalCenter = newlyCreatedFace.center
//            print("Gesture began \(point)")
        
            
        } else if panGestureRecognizer.state == .changed {
 //           print("Gesture changed \(point)")
          //  if velocity.y < 0 {
                newlyCreatedFace.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        //    }
            
        } else if panGestureRecognizer.state == .ended {
//            print("Gesture ended \(point)")
            print(newlyCreatedFace.center)
            print(trayView.frame.origin.y)
            
            if (newlyCreatedFace.frame.origin.y + newlyCreatedFace.frame.height) > trayView.frame.origin.y {
                newlyCreatedFace.removeFromSuperview()
            }
        }
        
    }

    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterWhenClosed = trayView.center
        print(view.bounds.maxY)
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: view.bounds.maxY - (trayView.frame.height / 2))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

