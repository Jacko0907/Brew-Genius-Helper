import SwiftUI
import ConfettiSwiftUI
import Combine

final class AchievementsManager: ObservableObject {
    // Persistent progress
    @AppStorage("totalCorrectAnswers") var totalCorrectAnswers = 0
    @AppStorage("quizzesCompleted") var quizzesCompleted = 0

    // Achievement flags (persisted)
    @AppStorage("perfectABVUnlocked") var perfectABVUnlocked = false
    @AppStorage("fiftyCorrectUnlocked") var fiftyCorrectUnlocked = false
    @AppStorage("firstQuizUnlocked") var firstQuizUnlocked = false

    // UI triggers
    @Published var confettiCounter = 0
    @Published var justUnlocked: String? = nil
    @Published var confettiTrigger: Bool = false

    func fireConfetti() {
        confettiTrigger.toggle()
    }

    func recordQuizResult(score: Int, total: Int, quizName: String) {
        totalCorrectAnswers += score
        quizzesCompleted += 1

        // #1 Perfect score on ABV and IBU quiz
        if quizName == "ABV & IBU Quiz", score == total, perfectABVUnlocked == false {
            perfectABVUnlocked = true
            trigger("🏆 Perfect Score on ABV & IBU Quiz!")
        }

        // #2 Answer 50 questions correctly
        if totalCorrectAnswers >= 50, fiftyCorrectUnlocked == false {
            fiftyCorrectUnlocked = true
            trigger("🍺 Answered 50 Questions Correctly!")
        }

        // #3 Finish your first quiz
        if quizzesCompleted == 1, firstQuizUnlocked == false {
            firstQuizUnlocked = true
            trigger("🎓 Finished Your First Quiz!")
        }
    }

    private func trigger(_ message: String) {
        justUnlocked = message
        confettiCounter += 1   // Only fire confetti when something unlocks
    }

    func clearToastAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            withAnimation { self?.justUnlocked = nil }
        }
    }

    // For testing/reset
    func resetAll() {
        totalCorrectAnswers = 0
        quizzesCompleted = 0
        perfectABVUnlocked = false
        fiftyCorrectUnlocked = false
        firstQuizUnlocked = false
        justUnlocked = nil
        confettiCounter = 0
    }
}
