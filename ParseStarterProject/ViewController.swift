//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse //parseをしっかりとインポートする

class ViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var albumImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //TODO:GameScoreにscore,playerName,cheatModeをそれぞれ保存している GameScoreがない場合は作成する
    @IBAction func upObjectButton(){
        var gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 1337456
        gameScore["tensuu"] = 102020
        gameScore["playerName"] = "Sean Plott"
        gameScore["cheatMode"] = false
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Save to GameScore")
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    //TODO:画像をアップロードする
    @IBAction func upImageButton(){
        let image = UIImage(named: "Parse.jpg")
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        var userPhoto = PFObject(className:"useforPhoto")
        userPhoto["imageName"] = "My trip to Hawaii!"
        userPhoto["imageFile"] = imageFile
        userPhoto.saveInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            // Handle success or failure here ...
            println("success")
        }
    }
    
    @IBAction func dlObjectButton(){
        var query = PFQuery(className:"GameScore")
        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    @IBAction func dlImageButton(){
        var query = PFQuery(className:"UserPhoto")
        query.whereKey("imageName", equalTo:"My trip to Hawaii!")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                    let userImageFile = object["imageFile"] as PFFile
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if error == nil {
                            let image = UIImage(data:imageData)
                            self.imageView.image = image
                        }
                    }
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

