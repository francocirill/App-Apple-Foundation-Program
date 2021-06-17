//
//  WatchConnectivityManager.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 17/06/21.
//

//import Foundation
//import WatchKit
//import WatchConnectivity
//import Combine
//
//class WatchConnectivityManager : NSObject, WCSessionDelegate
//{
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//
//    }
//
//    static let sharedInstance: WatchConnectivityManager = WatchConnectivityManager()
//
//    let theSession: WCSession = WCSession.default
//
//    override init()
//    {
//        super.init()
//
//        // Set the delegate of the WCSession
//        theSession.delegate = self
//
//        // Activate the session so that it will start receiving delegate callbacks
//        theSession.activate()
//    }
//
//    // Used solely to initialize the singleton for the class, which calls the constructor and activates the event listeners
//    func start()
//    {
//
//    }
//
//    // Both apps must be active to send a message
//    func sendStringToWatch(message:String, callback:([String : AnyObject]) -> ())
//    {
//        // Send the message to the Watch
//        theSession.sendMessage(["testString" : message], replyHandler:
//        { (reply: [String : Any]) -> Void in
//            // Handle the reply here
//
//            // Send the reply in the callback
//            callback(reply)
//        },
//        errorHandler:
//        { (error:NSError) -> Void in
//            // Handle the error here
//
//        })
//    }
//
//    // A message was sent by the Watch and received by the iOS app. This does NOT handle replies to messages sent from the iOS app
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void)
//    {
//        // Handle received message logic here
//
//        if (message["testString"] != nil)
//        {
//            replyHandler(["testString" : "Received Message!"])
//        }
//    }
//}
