import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var achievements: AchievementsManager

    var body: some View {
        List {
            Section(header: Text("Progress")) {
                HStack {
                    Label("Quizzes Completed", systemImage: "checkmark.seal")
                    Spacer()
                    Text("\(achievements.quizzesCompleted)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Label("Total Correct Answers", systemImage: "number")
                    Spacer()
                    Text("\(achievements.totalCorrectAnswers)")
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Achievements")) {
                row("🏆 Perfect Score on ABV and IBU Quiz", isUnlocked: achievements.perfectABVUnlocked)
                row("🍺 50 Questions Correct", isUnlocked: achievements.fiftyCorrectUnlocked)
                row("🎓 First Quiz Completed", isUnlocked: achievements.firstQuizUnlocked)
            }

            Section {
                Button(role: .destructive) {
                    achievements.resetAll()
                } label: {
                    Label("Reset Achievements", systemImage: "arrow.counterclockwise")
                }
            }
        }
        .navigationTitle("Achievements")
    }

    private func row(_ title: String, isUnlocked: Bool) -> some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: isUnlocked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isUnlocked ? .green : .secondary)
        }
    }
}
