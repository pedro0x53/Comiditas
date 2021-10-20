//
//  AppDelegate.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 13/09/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureUserNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Comiditas")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (
                                    UNNotificationPresentationOptions
                                ) -> Void) {

        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        if response.notification.request.identifier == "reminder" {
            print("Handling notifications with the local notification identifier")
        }

        completionHandler()
    }

    private func configureUserNotifications() {
      UNUserNotificationCenter.current().delegate = self

    let categoryIdentifier = "Notification"

      let markAsSnooze = UNNotificationAction(
        identifier: "snooze",
        title: StepsLocalizable.timerNotificationMarkAsSnooze.text,
        options: []
      )
        let deleteAction = UNNotificationAction(
          identifier: "delete",
          title: StepsLocalizable.timerNotificationDelete.text,
          options: [.destructive]
        )
        let category = UNNotificationCategory(
          identifier: categoryIdentifier,
          actions: [markAsSnooze, deleteAction],
          intentIdentifiers: [],
          options: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
