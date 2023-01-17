//
//  ContentView.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.displayScale) var displayScale
    @StateObject private var viewModel = DrawClassifierViewModel()
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                Text(viewModel.classification)
                    .font(.title2)
                    .foregroundColor(.primary)
                
                Spacer()
                
                DrawCanvasView(
                    currentLine: $viewModel.currentLine,
                    lines: $viewModel.lines
                )
                .frame(maxHeight: 600)
                .border(.secondary, width: 0.5)
                .padding(.vertical, 5)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Button("Classify") {
                        withAnimation(.linear(duration: 0.2)) {
                            viewModel.classifyImage(displayScale, size: geometry.size)
                        }
                    }
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(5)
                    
                    Button("Clear") {
                        withAnimation(.linear(duration: 0.2)) {
                            viewModel.clearDrawing()
                        }
                    }
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(5)
                    
                } //: HStack
                
                Spacer()
                
            } //: VStack
            
        } //: GeometryReader
        
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
