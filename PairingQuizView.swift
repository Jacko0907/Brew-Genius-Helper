import SwiftUI
import ConfettiSwiftUI

struct PairingQuizView: View {
    @EnvironmentObject var achievements: AchievementsManager

    @State private var index = 0
    @State private var feedback = ""
    @State private var score = 0
    @State private var finished = false

    struct PairingQuestion {
        let beer: String
        let correctAnswer: String
        let choices: [String]
    }

    @State private var questions: [PairingQuestion] = [
        PairingQuestion(
            beer: "Lightswitch Lager",
            correctAnswer: "A",
            choices: [
                "A. Cherry Chipotle Glazed Salmon",
                "B. Bacon Cheeseburger",
                "C. BBQ Baby Back Ribs",
                "D. Gluten Free Pizookie"
            ]
        ),
        PairingQuestion(
            beer: "Brewhouse Blonde",
            correctAnswer: "C",
            choices: [
                "A. BBQ Tri-tip",
                "B. Chocolate Chip Pizookie",
                "C. Blonde Fish 'N' Chips",
                "D. Sriracha Brussels Sprouts"
            ]
        ),
        PairingQuestion(
            beer: "Harvest Hefeweizen",
            correctAnswer: "D",
            choices: [
                "A. Broccoli Cheddar Soup",
                "B. Nashville Hot Bone in Wings",
                "C. Mozzarella Sticks",
                "D. Strawberry Fields Salad"
            ]
        ),
        PairingQuestion(
            beer: "Piranha Pale Ale",
            correctAnswer: "A",
            choices: [
                "A. Spicy Pig Pizza",
                "B. Asian Chop Salad",
                "C. Epic 5 Meat Pizza",
                "D. Chicken Pot Stickers"
            ]
        ),
        PairingQuestion(
            beer: "Hopstorm IPA",
            correctAnswer: "B",
            choices: [
                "A. Hickory Brisket Burger",
                "B. Spicy Peanut Chicken Soba",
                "C. Sliders With Fries",
                "D. Vegetarian Pizza"
            ]
        ),
        PairingQuestion(
            beer: "Committed Double IPA",
            correctAnswer: "C",
            choices: [
                "A. Smokehouse Burger",
                "B. All-American Smash Burger",
                "C. Crispy Jalapeño Burger",
                "D. Classic Cheeseburger"
            ]
        ),
        PairingQuestion(
            beer: "Oasis Amber",
            correctAnswer: "D",
            choices: [
                "A. Chicken Caesar Salad",
                "B. Sweet Potato Fries",
                "C. Mediterranean Tacos",
                "D. Jumbo Spaghetti and Meatballs"
            ]
        ),
        PairingQuestion(
            beer: "Jeremiah Red",
            correctAnswer: "C",
            choices: [
                "A. Gluten Free Cheese Pizza",
                "B. Vegetarian Brewhouse Bowl",
                "C. Tri-Tip Wedge Salad",
                "D. Mozzarella Tomato Salad"
            ]
        ),
        PairingQuestion(
            beer: "Nutty Brewnette",
            correctAnswer: "A",
            choices: [
                "A. BBQ Baby Back Ribs",
                "B. Wedge Salad",
                "C. Sal's Brewhouse Chicken",
                "D. Classic Combo Pizza"
            ]
        ),
        PairingQuestion(
            beer: "Sweet Sin Porter",
            correctAnswer: "B",
            choices: [
                "A. California Flatbread",
                "B. Triple Chocolate Pizookie",
                "C. Parmesan Crusted Chicken",
                "D. Clam Chowder"
            ]
        ),
        PairingQuestion(
            beer: "Tatonka Stout",
            correctAnswer: "C",
            choices: [
                "A. Chips and Housemade Guacamole",
                "B. Gluten Free BBQ Chicken Pizza",
                "C. Strawberry Shortcake Pizookie",
                "D. Tri-Tip Brewhouse Bowl"
            ]
        ),
        PairingQuestion(
            beer: "Berryburst Cider",
            correctAnswer: "D",
            choices: [
                "A. Cookies N Cream Pizookie",
                "B. Chocolate Chip Pizookie",
                "C. Sugar Cookie Pizookie",
                "D. Gluten Free Pizookie"
            ]
        )
    ]

    var body: some View {
        ScrollView {
            if let currentQuestion = currentQuestion {
                VStack(spacing: 20) {
                    Text("Menu Pairing Quiz")
                        .font(.largeTitle)
                        .bold()

                    Text("What pairs with \(currentQuestion.beer)?")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)

                    ForEach(currentQuestion.choices, id: \.self) { choice in
                        Button(action: {
                            checkAnswer(choice)
                        }) {
                            Text(choice)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.85))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                        }
                    }

                    if !feedback.isEmpty {
                        Text(feedback)
                            .foregroundColor(feedback.contains("Correct") ? .green : .red)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 20)

                        Button(index < questions.count - 1 ? "Next Question" : "Finish Quiz") {
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
                                Text("\(index + 1) / \(questions.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            ProgressView(value: Double(index + 1), total: Double(questions.count))
                                .progressViewStyle(.linear)
                        }
                        .padding(.horizontal)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    }
                    .padding(.horizontal)
                }
                .padding()
            } else {
                ContentUnavailableView("No pairing questions available", systemImage: "fork.knife")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .overlay(achievementOverlay)
        .onAppear {
            resetQuiz()
        }

    }

    private var currentQuestion: PairingQuestion? {
        guard questions.indices.contains(index) else { return nil }
        return questions[index]
    }

    // MARK: - Confetti & Achievement Overlay
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
                .transition(.scale)
                .onAppear { achievements.clearToastAfterDelay() }
            }

            ConfettiCannon(
                trigger: $achievements.confettiTrigger,
                num: 50,
                colors: [.yellow, .orange, .red]
            )
            .allowsHitTesting(false)
            .frame(maxHeight: 300)
        }
    }

    // MARK: - Quiz Logic
    private func checkAnswer(_ choice: String) {
        guard let currentQuestion = currentQuestion else { return }
        let correctLetter = currentQuestion.correctAnswer

        if choice.hasPrefix(correctLetter) {
            feedback = "✅ Correct!"
            score += 1
        } else {
            if let correct = currentQuestion.choices.first(where: { $0.hasPrefix(correctLetter) }) {
                feedback = "❌ Incorrect. Correct answer: \(correct)"
            } else {
                feedback = "❌ Incorrect."
            }
        }
    }

    private func nextQuestion() {
        feedback = ""
        if index < questions.count - 1 {
            index += 1
        } else {
            finished = true
            achievements.recordQuizResult(
                score: score,
                total: questions.count,
                quizName: "Menu Pairing Quiz"
            )
        }
    }

    private func resetQuiz() {
        index = 0
        feedback = ""
        score = 0
        finished = false
        questions.shuffle()
    }
}
