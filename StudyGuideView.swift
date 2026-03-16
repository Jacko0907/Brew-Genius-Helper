import SwiftUI

struct StudyGuideView: View {
    private let abvAndIbuItems: [ABVStudyItem] = [
        ABVStudyItem(beer: "Lightswitch Lager", abv: "3.5", ibu: "16"),
        ABVStudyItem(beer: "Brewhouse Blonde", abv: "4.7", ibu: "15"),
        ABVStudyItem(beer: "Harvest Hefeweizen", abv: "4.9", ibu: "15"),
        ABVStudyItem(beer: "Piranha Pale Ale", abv: "5.7", ibu: "40"),
        ABVStudyItem(beer: "Hopstorm IPA", abv: "6.5", ibu: "65"),
        ABVStudyItem(beer: "Committed Double IPA", abv: "8.6", ibu: "95"),
        ABVStudyItem(beer: "Oasis Amber", abv: "4.7", ibu: "19"),
        ABVStudyItem(beer: "Jeremiah Red", abv: "7.3", ibu: "25"),
        ABVStudyItem(beer: "Sweet Sin Porter", abv: "6.5", ibu: "29"),
        ABVStudyItem(beer: "Tatonka Stout", abv: "8.5", ibu: "50"),
        ABVStudyItem(beer: "Berryburst Cider", abv: "3.0", ibu: "0")
    ]

    private let descriptionItems: [StudyGuideItem] = [
        StudyGuideItem(
            title: "Lightswitch Lager",
            detail: "Low calorie, pleasant malt flavor and a clean, dry finish."
        ),
        StudyGuideItem(
            title: "Brewhouse Blonde",
            detail: "German Kolsch, crisp hybrid of a lager and an ale with a slightly malt sweetness."
        ),
        StudyGuideItem(
            title: "Harvest Hefeweizen",
            detail: "Bavarian-style wheat beer that is fruity, spicy and refreshing with banana and clove."
        ),
        StudyGuideItem(
            title: "Piranha Pale Ale",
            detail: "Hopped with copious amounts of five different hops for a snappy flavor and bite."
        ),
        StudyGuideItem(
            title: "Hopstorm IPA",
            detail: "Six different hop varieties contribute to make it profoundly hoppy with balanced bitterness."
        ),
        StudyGuideItem(
            title: "Committed Double IPA",
            detail: "A robust IPA with smooth drinkability, pronounced hop character with fruity, earthy notes."
        ),
        StudyGuideItem(
            title: "Oasis Amber",
            detail: "Delicious malty flavor with the smooth drinkability of a pale lager."
        ),
        StudyGuideItem(
            title: "Jeremiah Red",
            detail: "The roasted barley and kilned malts provide delicious notes of caramel, toffee, and butter."
        ),
        StudyGuideItem(
            title: "Sweet Sin Chocolate Porter",
            detail: "Notes of dark chocolate and roasted coffee. The beer is designed to be a dessert lover's dream."
        ),
        StudyGuideItem(
            title: "Tatonka Stout",
            detail: "With just the right amount of malt for sweetness and hops for bitterness for a full-bodied and complex ale."
        ),
        StudyGuideItem(
            title: "Berryburst Cider",
            detail: "A gluten-free cider, intensely aromatic with a deliciously sweet medley of berries."
        )
    ]

    private let pairingItems: [StudyGuideItem] = [
        StudyGuideItem(title: "Lightswitch Lager", detail: "Cherry Chipotle Glazed Salmon"),
        StudyGuideItem(title: "Brewhouse Blonde", detail: "Blonde Fish 'N' Chips"),
        StudyGuideItem(title: "Harvest Hefeweizen", detail: "Strawberry Fields Salad"),
        StudyGuideItem(title: "Piranha Pale Ale", detail: "Spicy Pig Pizza"),
        StudyGuideItem(title: "Hopstorm IPA", detail: "Spicy Peanut Chicken Soba"),
        StudyGuideItem(title: "Committed Double IPA", detail: "Crispy Jalapeno Burger"),
        StudyGuideItem(title: "Oasis Amber", detail: "Jumbo Spaghetti and Meatballs"),
        StudyGuideItem(title: "Jeremiah Red", detail: "Tri-Tip Wedge Salad"),
        StudyGuideItem(title: "Nutty Brewnette", detail: "BBQ Baby Back Ribs"),
        StudyGuideItem(title: "Sweet Sin Porter", detail: "Triple Chocolate Pizookie"),
        StudyGuideItem(title: "Tatonka Stout", detail: "Strawberry Shortcake Pizookie"),
        StudyGuideItem(title: "Berryburst Cider", detail: "Gluten Free Pizookie")
    ]

    private let flashCards: [StudyGuideItem] = [
        StudyGuideItem(title: "What does ABV stand for?", detail: "Alcohol by volume"),
        StudyGuideItem(title: "What does IBU stand for?", detail: "International bitterness units"),
        StudyGuideItem(title: "What angle should the glass be held when pouring?", detail: "45 degree angle"),
        StudyGuideItem(title: "What's the difference between Nutty Brewnette and traditional brown ales?", detail: "Nutty Brewnette is hoppier"),
        StudyGuideItem(title: "What PSI should CO2 beers be poured at?", detail: "18-22 PSI"),
        StudyGuideItem(title: "What PSI should nitro beers be poured at?", detail: "35-40 PSI"),
        StudyGuideItem(title: "When should you check someone's ID?", detail: "When they look under 30"),
        StudyGuideItem(title: "What do you do when a guest is undecided about a beer?", detail: "Bring a skosh"),
        StudyGuideItem(title: "When do you suggest a guest purchase a pitcher?", detail: "We do not serve pitchers"),
        StudyGuideItem(title: "What is the purpose of hops?", detail: "Adds aroma and bitterness"),
        StudyGuideItem(title: "What is the purpose of malt?", detail: "Adds sweetness and color"),
        StudyGuideItem(title: "How much head should be on a beer?", detail: "1/2 to 3/4 inch, which helps with aroma and flavor"),
        StudyGuideItem(title: "How can you tell if a glass is dirty?", detail: "Bubbles on the side and little to no head"),
        StudyGuideItem(title: "Name the city/state of the 5 breweries", detail: "Chandler, AZ | Boulder, CO | Reno, NV | West Covina, CA | Temple, TX"),
        StudyGuideItem(title: "Why are Tatonka and Committed served in 12oz glasses?", detail: "High alcohol percentage"),
        StudyGuideItem(title: "What are the 10 steps of brewing?", detail: "Malting, Milling, Mashing, Lautering, Boiling, Cooling, Fermenting, Conditioning, Filtering, Packaging")
    ]

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Review every answer from the quizzes and flash cards in one place.")
                        .font(.headline)
                    Text("Use this as a quick memorization sheet before taking the quizzes.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }

            Section("ABV and IBU") {
                ForEach(abvAndIbuItems) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.beer)
                            .font(.headline)
                        Text("ABV: \(item.abv)%")
                        Text("IBU: \(item.ibu)")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }

            Section("Beer Descriptions") {
                ForEach(descriptionItems) { item in
                    StudyGuideRow(item: item)
                }
            }

            Section("Menu Pairings") {
                ForEach(pairingItems) { item in
                    StudyGuideRow(item: item)
                }
            }

            Section("Flash Card Facts") {
                ForEach(flashCards) { item in
                    StudyGuideRow(item: item)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Study Guide")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ABVStudyItem: Identifiable {
    let id = UUID()
    let beer: String
    let abv: String
    let ibu: String
}

private struct StudyGuideItem: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

private struct StudyGuideRow: View {
    let item: StudyGuideItem

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.headline)
            Text(item.detail)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 2)
    }
}
