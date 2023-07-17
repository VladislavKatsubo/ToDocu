//
//  AppDelegate.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

protocol AppDelegateProtocol {
    var context: AppContext! { get }
    var window: UIWindow? { get }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppDelegateProtocol {
    static let shared: AppDelegateProtocol = UIApplication.shared.delegate as! AppDelegateProtocol

    var context: AppContext!
    var mainFlow: MainFlow!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        context = AppContext.context()

        mainFlow = MainFlow(navigator: MainFlowNavigator())
        guard mainFlow.makeStartFlow(window: window) else { return false }

        return true
    }
}
