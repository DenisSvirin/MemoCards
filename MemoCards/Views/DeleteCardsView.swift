//
//  DeleteCardsView.swift
//  MemoCards
//
//  Created by Denis Svirin on 23.02.2023.
//

import SwiftUI

struct DeleteCardsView: View {
    let card: CardEntity
    @Binding var cardsToDelete: [CardEntity]
    var body: some View {
       
            if cardsToDelete.contains(card) {
                CardView(icon: Image(systemName: "checkmark.circle") ,question: card.question ?? "?", answer: card.answer ?? "?", correct_guesses: Int(card.correct_guesses), wrong_guesses: Int(card.wrong_guesses))
                    .onTapGesture {
                        if let index = cardsToDelete.firstIndex(of: card) {
                                        cardsToDelete.remove(at: index)
                        }
                }
            }
            else{
                CardView(icon: Image(systemName: "circle"), question: card.question ?? "?", answer: card.answer ?? "?", correct_guesses: Int(card.correct_guesses), wrong_guesses: Int(card.wrong_guesses))
                    .onTapGesture {
                        cardsToDelete.append(card)
                        }
        }
    }
}

