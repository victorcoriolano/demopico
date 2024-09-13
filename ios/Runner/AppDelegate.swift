import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyD9Vb3pQkxxG7Hp28-q-1KshsJ9NqIq6Cw")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
