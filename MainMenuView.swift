import SwiftUI

struct MainMenuView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var achievements: AchievementsManager

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 8) {
                    Text("🍺 Brew Genius Helper")
                        .font(.largeTitle).bold()
                    Text("Select a quiz or feature to begin")
                        .font(.headline).foregroundColor(.gray)
                }
                .padding(.top, 60)

                Spacer()

                VStack(spacing: 25) {
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
                        Text("Achievements")
                            .font(.title2).fontWeight(.bold)
                            .frame(maxWidth: .infinity).frame(height: 70)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(16).shadow(radius: 6)
                    }
                }
                .padding(.horizontal, 30)

                Spacer()

                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .font(.title3).fontWeight(.semibold)
                }
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .padding()
            .navigationTitle("Main Menu")
        }
    }

    private func menuButton(title: String) -> some View {
        Text(title)
            .font(.title2).fontWeight(.bold)
            .frame(maxWidth: .infinity).frame(height: 70)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(radius: 6)
    }
}
