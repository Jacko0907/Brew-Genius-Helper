import SwiftUI
import ConfettiSwiftUI

struct BeerQuestion {
    let name: String
    let choices: [String]
    let correctAnswer: String
}

struct BeerDescriptionView: View {
    @EnvironmentObject var achievements: AchievementsManager

    @State private var currentIndex = 0
    @State private var feedback = ""
    @State private var quizFinished = false
    @State private var score = 0

    @State private var questions: [BeerQuestion] = [
        BeerQuestion(name: "Lightswitch Lager",
                     choices: ["A. Low calorie, pleasant malt flavor and a clean, dry finish",
                               "B. German Kolsch, crisp hybrid of a lager and an ale. With a slightly malt sweetness.",
                               "C. Not too hoppy, with just the right amount of malt. It offers a clean, crisp taste",
                               "D. Copious amounts of five different hops for a snappy flavor and bite, Hoppy, Citrusy, Tropical, Bitter, Crisp"],
                     correctAnswer: "A"),
        BeerQuestion(name: "Brewhouse Blonde",
                     choices: ["A. Malty sweet, hop-bitter, full-bodied and deliciously complex",
                               "B. Pleasant malt flavor and a clean, dry finish",
                               "C. Complex hop character to make it profoundly hoppy with balanced bitterness",
                               "D. German Kolsch, crisp hybrid of a lager and an ale. With a slightly malt sweetness."],
                     correctAnswer: "D"),
        BeerQuestion(name: "Harvest Hefeweizen",
                     choices: ["A. Bavarian-style wheat beer that is fruity, spicy and refreshing with banana and clove",
                               "B. Smooth drinkability, pronounced hop character with fruity, earthy notes",
                               "C. Sweet and nutty, balanced by a healthy dose of hops",
                               "D. Intensely aromatic with a deliciously sweet medley of berries"],
                     correctAnswer: "A"),
        BeerQuestion(name: "Piranha Pale Ale",
                     choices: ["A. Profoundly hoppy with balanced bitterness",
                               "B. Hopped with copious amounts of five different hops for a snappy flavor and bite",
                               "C. Chocolate flavors fill the palate. Balanced well with a dry roasted finish.",
                               "D. Smooth drinkability, pronounced hop character with fruity, earthy notes"],
                     correctAnswer: "B"),
        BeerQuestion(name: "Hopstorm IPA",
                     choices: ["A. Hopped with copious amounts of five different hops, Hoppy, Citrusy, Tropical, Bitter, Crisp",
                               "B. A robust IPA with smooth drinkability, pronounced hop character with fruity, earthy notes.",
                               "C. Six different hop varieties contribute to make it profoundly hoppy with balanced bitterness",
                               "D. Made with four different brown malts and a healthy dose of hops that distinguishes it"],
                     correctAnswer: "C"),
        BeerQuestion(name: "Committed Double IPA",
                     choices: ["A. A robust IPA with smooth drinkability, pronounced hop character with fruity, earthy notes",
                               "B. Hopped with copious amounts of five different hops, Hoppy, Citrusy, Tropical, Bitter, Crisp",
                               "C. Brewed with a secret blend of five imported specialty malts, delicious notes of caramel, toffee, and butter",
                               "D. Malty sweet, hop-bitter, full-bodied and deliciously complex"],
                     correctAnswer: "A"),
        BeerQuestion(name: "Oasis Amber",
                     choices: ["A. Delicious malty flavor with the smooth drinkability of a pale lager.",
                               "B. Wheat beer that is fruity, spicy and refreshing.",
                               "C. A pleasant lager balanced by a clean, dry finish.",
                               "D. Roasted barley and brewed with a secret blend of five imported specialty malts."],
                     correctAnswer: "A"),
        BeerQuestion(name: "Jeremiah Red",
                     choices: ["A. A sweet and nutty brown ale that is balanced by a healthy dose of hops",
                               "B. A robust IPA with smooth drinkability, pronounced hop character with fruity, earthy notes.",
                               "C. The roasted barley and kilned malts provide delicious notes of caramel, toffee, and butter.",
                               "D. Malty sweet, hop-bitter, full-bodied and deliciously complex"],
                     correctAnswer: "C"),
        BeerQuestion(name: "Sweet Sin Chocolate Porter",
                     choices: ["A. A stout that delivers the traditional nutty and cocoa tastes",
                               "B. Caramel, molasses, and chocolate flavors fill the palate. Balanced well with a dry roasted finish.",
                               "C. Delicious notes of caramel, toffee, and butter.",
                               "D. Notes of dark chocolate and roasted coffee. The beer is designed to be a dessert lover's dream"],
                     correctAnswer: "D"),
        BeerQuestion(name: "Tatonka Stout",
                     choices: ["A. Balanced by a clean, dry finish. Only 140 calories per pint!",
                               "B. Caramel, molasses, and chocolate flavors fill the palate. Balanced well with a dry roasted finish",
                               "C. With just the right amount of malt for sweetness and hops for bitterness for a full-bodied and complex ale",
                               "D. Not too hoppy, with just the right amount of malt. It offers a clean, crisp taste with a lower alcohol volume."],
                     correctAnswer: "C"),
        BeerQuestion(name: "Berryburst Cider",
                     choices: ["A. Wheat beer that is fruity, spicy and refreshing.",
                               "B. A gluten-free cider, intensely aromatic with a deliciously sweet medley of berries.",
                               "C. Pronounced hop character with fruity, earthy notes.",
                               "D. Great everyday beer that is smooth and not too hoppy."],
                     correctAnswer: "B")
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Beer Description Quiz")
                .font(.largeTitle)
                .bold()

            Text("Choose the correct description for \(questions[currentIndex].name)")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)

            ForEach(questions[currentIndex].choices, id: \.self) { choice in
                Button(choice) {
                    checkAnswer(choice)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            }

            if !feedback.isEmpty {
                Text(feedback)
                    .foregroundColor(feedback.contains("Correct") ? .green : .red)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)

                Button(currentIndex < questions.count - 1 ? "Next Question" : "Finish Quiz") {
                    nextQuestion()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 24)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Progress")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(currentIndex + 1) / \(questions.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                        .progressViewStyle(.linear)
                }
                .padding(.horizontal)

                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .overlay(achievementOverlay)
        .onAppear {
            questions.shuffle()
        }

    }

    private var achievementOverlay: some View {
        ZStack {
            if let unlocked = achievements.justUnlocked {
                VStack(spacing: 8) {
                    Text("✨ Achievement Unlocked!")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    Text(unlocked)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.black.opacity(0.75))
                .cornerRadius(12)
                .onAppear { achievements.clearToastAfterDelay() }
                .transition(.scale)
            }

            ConfettiCannon(
                trigger: $achievements.confettiTrigger,
                num: 50,
                colors: [.yellow, .orange, .red]
            )
            .allowsHitTesting(false)
            .frame(maxHeight: 300)
        }
        .animation(.easeInOut, value: achievements.justUnlocked)
    }

    // MARK: - Quiz Logic
    private func checkAnswer(_ choice: String) {
        let correct = questions[currentIndex].correctAnswer
        if choice.hasPrefix(correct) {
            feedback = "✅ Correct!"
            score += 1
        } else {
            feedback = "❌ Incorrect. Correct answer: \(correct)"
        }
    }

    private func nextQuestion() {
        feedback = ""
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            quizFinished = true
            achievements.recordQuizResult(score: score, total: questions.count, quizName: "Beer Description Quiz")
        }
    }
}
