import SwiftUI
import Foundation

@main
struct BrewGeniusApp: App {
    @StateObject private var achievements = AchievementsManager()

    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(achievements)
        }
    }
}
