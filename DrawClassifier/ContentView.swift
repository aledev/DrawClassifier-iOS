//
//  ContentView.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = DrawClassifierViewModel()
    
    // MARK: - Body
    var body: some View {
        
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
                        viewModel.classifyImage()
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
        
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
