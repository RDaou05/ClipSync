//
//  ShareViewController.swift
//  ClipShare
//
//  Created by Roni Daou on 3/1/24.
//

import UIKit
import Social
import FirebaseCore
import FirebaseFirestore
import WebKit
import FirebaseFirestore
import FirebaseAuth



// @UIApplicationMain
// class AppDelegate: UIResponder, UIApplicationDelegate {

// //   var window: UIWindow?

//   func application(_ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions:
//                    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//     FirebaseApp.configure()

//     return true
//   }
// }



class ShareViewController: SLComposeServiceViewController {
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    //   var window: UIWindow?

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
                    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        

        return true
    }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func viewDidLoad() {
        FirebaseApp.configure()
        
        if let currentUser = Auth.auth().currentUser {
            let userID = currentUser.uid
            // Now you can use the userID as needed
            print("User ID: \(userID)")
        } else {
            // User is not logged in
            print("User is not logged in.")
        }
        super.viewDidLoad()
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let attachments = item.attachments as? [NSItemProvider] {
            
            for attachment in attachments {
                if attachment.hasItemConformingToTypeIdentifier("public.url") {
                    attachment.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                        if let shareURL = url as? URL {
                            // Handle the shared URL (shareURL)
                            // You can use shareURL.absoluteString to get the URL strings
                            do {
                              try  // Get a reference to your Firestore database
                                // Initialize Firestore
                                FirebaseApp.configure()
                            
                                let db = Firestore.firestore()
                                // Example: Add the video URL to a Firestore collection
                                db.collection("videos").addDocument(data: [
                                    "videourl": shareURL.absoluteString
                                ]) { error in
                                    if let error = error {
                                        print("Error adding document:")
                                    } else {
                                        print("Document added with ID:")
                                    }
                                }
                            } catch let error {
                            print("Error writing city to Firestore: \(error)")
                            }
                        }
                    })
                }
            }
        }

        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
}
