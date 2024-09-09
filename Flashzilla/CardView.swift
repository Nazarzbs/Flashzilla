//
//  CardView.swift
//  Flashzilla
//
//  Created by Nazar on 3/9/24.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Binding var answerWasCorrect: Bool
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    let card: Card
    
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ?.white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .modifier(OffsetBackgroundModifier(offset: offset, accessibilityDifferentiateWithoutColor: accessibilityDifferentiateWithoutColor))
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        answerWasCorrect = false
                    } else {
                        answerWasCorrect = true
                    }
                    
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
            
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
    
    struct OffsetBackgroundModifier: ViewModifier {
        var offset: CGSize
        var accessibilityDifferentiateWithoutColor: Bool
        
        func body(content: Content) -> some View {
            content
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            accessibilityDifferentiateWithoutColor
                                ? Color.white
                                : (offset.width > 0 ? Color.green : Color.red)
                        )
                )
        }
    }
}

//#Preview {
//    CardView(card: .example, answerWasCorrect: <#Binding<Bool>#>)
//}
