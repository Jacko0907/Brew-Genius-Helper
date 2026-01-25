import SwiftUI

struct FlashCard: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FlashCardView: View {
    @State private var cards: [FlashCard] = [
        FlashCard(question: "What does ABV stand for?", answer: "Alcohol by volume"),
        FlashCard(question: "What does IBU stand for?", answer: "International bitterness units"),
        FlashCard(question: "What angle should the glass be held when pouring?", answer: "45 degree angle"),
        FlashCard(question: "What’s the difference between Nutty Brewnette and traditional brown ales?", answer: "Nutty Brewnette is hoppier"),
        FlashCard(question: "What PSI should CO2 beers be poured at?", answer: "18–22 PSI"),
        FlashCard(question: "What PSI should nitro beers be poured at?", answer: "35–40 PSI"),
        FlashCard(question: "When should you check someone's ID?", answer: "When they look under 30"),
        FlashCard(question: "What do you do when a guest is undecided about a beer?", answer: "Bring a skosh"),
        FlashCard(question: "When do you suggest a guest purchase a pitcher?", answer: "We do not serve pitchers"),
        FlashCard(question: "What is the purpose of hops?", answer: "Adds aroma and bitterness"),
        FlashCard(question: "What is the purpose of malt?", answer: "Adds sweetness and color"),
        FlashCard(question: "How much head should be on a beer?", answer: "½ to ¾ inch — helps with aroma and flavor"),
        FlashCard(question: "How can you tell if a glass is dirty?", answer: "Bubbles on the side and little to no head"),
        FlashCard(question: "Name the city/state of the 5 breweries", answer: "Chandler, AZ | Boulder, CO | Reno, NV | West Covina, CA | Temple, TX"),
        FlashCard(question: "Why are Tatonka and Committed served in 12oz glasses?", answer: "High alcohol percentage"),
        FlashCard(question: "What are the 10 steps of brewing?", answer: "Malting, Milling, Mashing, Lautering, Boiling, Cooling, Fermenting, Conditioning, Filtering, Packaging")
    ]
    
    @State private var currentIndex = 0
    @State private var showAnswer = false
    @State private var flippedAngle = 0.0
    @State private var shuffled = false
    
    var body: some View {
        VStack(spacing: 25) {
            // Title and progress
            Text("Flash Cards")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            Text("Card \(currentIndex + 1) of \(cards.count)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
            
            // 3D Flip Card (fixed orientation)
            ZStack {
                // Front: Question
                CardFaceView(text: cards[currentIndex].question, background: Color.white)
                    .opacity(showAnswer ? 0 : 1)
                    .rotation3DEffect(.degrees(showAnswer ? 180 : 0),
                                      axis: (x: 0, y: 1, z: 0))
                
                // Back: Answer
                CardFaceView(text: cards[currentIndex].answer, background: Color.green.opacity(0.30))
                    .opacity(showAnswer ? 1 : 0)
                    // ✅ Flip the back text so it faces forward
                    .rotation3DEffect(.degrees(showAnswer ? 0 : -180),
                                      axis: (x: 0, y: 1, z: 0))
            }
            .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 300)
            .padding(.horizontal, 30)
            .animation(.easeInOut(duration: 0.6), value: showAnswer)

            
            Spacer()
            
            // Buttons
            VStack(spacing: 15) {
                Button(action: flipCard) {
                    Text(showAnswer ? "Hide Answer" : "Reveal Answer")
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                
                Button(action: nextQuestion) {
                    Text("Next Card")
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                
                Button(action: shuffleCards) {
                    Text(shuffled ? "Reset Order" : "🔀 Shuffle Cards")
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
            }
            
            Spacer(minLength: 40)
        }
        .padding()
        .navigationTitle("Flash Cards")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Logic
    private func flipCard() {
        withAnimation(.easeInOut(duration: 0.5)) {
            flippedAngle += 180
            showAnswer.toggle()
        }
    }
    
    private func nextQuestion() {
        withAnimation(.easeInOut(duration: 0.5)) {
            showAnswer = false
            flippedAngle = 0
            currentIndex = (currentIndex + 1) % cards.count
        }
    }
    
    private func shuffleCards() {
        withAnimation(.easeInOut(duration: 0.5)) {
            if shuffled {
                cards.sort { $0.question < $1.question }
                shuffled = false
                currentIndex = 0
            } else {
                cards.shuffle()
                shuffled = true
                currentIndex = 0
            }
            showAnswer = false
            flippedAngle = 0
        }
    }
}

//MARK: Card Face View
struct CardFaceView: View {
    let text: String
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(background)
                .shadow(radius: 6)
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        }
    }
}
