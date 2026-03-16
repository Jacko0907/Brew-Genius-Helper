import SwiftUI

struct MainMenuView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var achievements: AchievementsManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 28) {

                    // Header
                    VStack(spacing: 8) {
                        Text("🍺 Brew Genius Helper")
                            .font(.largeTitle).bold()
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.8)

                        Text("Select a quiz or feature to begin")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 16)

                    // Buttons
                    VStack(spacing: 16) {
                        NavigationLink(destination: StudyGuideView()) {
                            menuButton(title: "Study Guide")
                        }
                        NavigationLink(destination: ABVQuizView()) {
                            menuButton(title: "ABV and IBU Quiz")
                        }
                        NavigationLink(destination: PairingQuizView()) {
                            menuButton(title: "Menu Pairing Quiz")
                        }
                        NavigationLink(destination: BeerDescriptionView()) {
                            menuButton(title: "Beer Description Quiz")
                        }
                        NavigationLink(destination: FlashCardView()) {
                            menuButton(title: "Flash Cards")
                        }
                        NavigationLink(destination: AchievementsView()) {
                            achievementsButton()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 16)
            }
            .safeAreaInset(edge: .bottom) {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode",
                          systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
                    .font(.title3).fontWeight(.semibold)
                }
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle("Main Menu")
        }
    }

    private func menuButton(title: String) -> some View {
        Text(title)
            .font(.title2).fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .frame(height: 64)                 // slightly smaller helps on short screens
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(radius: 6)
            .contentShape(Rectangle())
    }

    private func achievementsButton() -> some View {
        Text("Achievements")
            .font(.title2).fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(16)
            .shadow(radius: 6)
            .contentShape(Rectangle())
    }
}
