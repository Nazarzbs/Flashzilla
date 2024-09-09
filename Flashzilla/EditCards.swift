//
//  EditCards.swift
//  Flashzilla
//
//  Created by Nazar on 4/9/24.
//

import SwiftUI
import SwiftData

struct EditCards: View {
    
    @Environment(\.dismiss) var dismiss
    @Query private var cards: [Card]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func done() {
        dismiss()
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer, created: Date.now)
        withAnimation {
            newPrompt = ""
            newAnswer = ""
        }
       
        modelContext.insert(card)
    }
    
    func removeCards(at offsets: IndexSet) {
        offsets.forEach { index in
            let cardToRemove = cards[index]
            modelContext.delete(cardToRemove)
        }
    }
}

#Preview {
    EditCards()
}
