import SwiftUI
import ConfettiSwiftUI


struct ABVQuizView: View {
    @EnvironmentObject var achievements: AchievementsManager
    @Environment(\.dismiss) var dismiss
    @State private var index = 0
    @State private var userAnswer = ""
    @State private var feedback = ""
    @State private var score = 0
    @State private var finished = false
    
    @State private var questions = [
        ("Lightswitch Lager", "3.5,16"),
        ("Brewhouse Blonde", "4.7,15"),
        ("Harvest Hefeweizen", "4.9,15"),
        ("Piranha Pale Ale", "5.7,40"),
        ("Hopstorm IPA", "6.5,65"),
        ("Committed Double IPA", "8.6,95"),
        ("Oasis Amber", "4.7,19"),
        ("Jeremiah Red", "7.3,25"),
        ("Sweet Sin Porter", "6.5,29"),
        ("Tatonka Stout", "8.5,50"),
        ("Berryburst Cider", "3.0,0")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                Text("Question \(index + 1) of \(questions.count)")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("Enter the ABV and IBU for \(questions[index].0)")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                
                TextField("e.g. 6.5,50", text: $userAnswer)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numbersAndPunctuation)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(maxWidth: 260)
                
                Button("Submit") { submit() }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                if !feedback.isEmpty {
                    Text(feedback)
                        .foregroundColor(feedback.contains("Correct") ? .green : .red)
                        .bold()
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 20)
                    
                    Button(index < questions.count - 1 ? "Next Question" : "Finish Quiz") {
                        if index < questions.count - 1 {
                            next()
                        } else {
                            achievements.recordQuizResult(score: score, total: questions.count, quizName: "ABV & IBU Quiz")
                            dismiss()
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer(minLength: 20)
                }
            }
            .navigationTitle("ABV and IBU Quiz")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(achievementOverlay)
            .onAppear { questions.shuffle() }
        }
    }
    
    // MARK: - Achievement & Confetti
    private var achievementOverlay: some View {
        Group {
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
    }
    
    // MARK: - Quiz Logic
    private func submit() {
        let correct = questions[index].1
        if userAnswer.trimmingCharacters(in: .whitespacesAndNewlines) == correct {
            feedback = "✅ Correct!"
            score += 1
        } else {
            let parts = correct.split(separator: ",")
            feedback = parts.count == 2
            ? "❌ Incorrect. \(questions[index].0) is \(parts[0]) ABV and \(parts[1]) IBU."
            : "❌ Incorrect. Correct answer: \(correct)."
        }
        userAnswer = ""
    }
    
    private func next() {
        feedback = ""
        if index < questions.count - 1 {
            index += 1
        } else {
            finished = true
            achievements.recordQuizResult(
                score: score,
                total: questions.count,
                quizName: "ABV & IBU Quiz"
            )
        }
    }
}
