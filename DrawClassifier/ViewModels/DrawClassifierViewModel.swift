//
//  DrawClassifierViewModel.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import Foundation
import SwiftUI

@MainActor
class DrawClassifierViewModel: ObservableObject {
    // MARK: - Properties
    @Published var classification: String = ""
    @Published var currentLine = Line()
    @Published var lines: [Line] = []
    
    private var drawClassifierService: DrawClassifierService? = nil
    
    // MARK: - Initializer
    init() {
        self.drawClassifierService = DrawClassifierService()
    }
    
    // MARK: - Functions
    func classifyImage() {
        guard let drawClassifierService = drawClassifierService else {
            return
        }
        
        let renderer = ImageRenderer(
            content: DrawCanvasView(
                currentLine: .constant(currentLine),
                lines: .constant(lines)
            )
        )
        
        guard let uiImage = renderer.uiImage,
              let resizedImage = uiImage.resizeTo(size: CGSize(width: 224, height: 224)) else {
            return
        }
        
        guard let drawClassification = drawClassifierService.classifyDraw(resizedImage) else {
            return
        }
        
        self.classification = drawClassification
    }
    
    func clearDrawing() {
        self.currentLine = Line()
        self.lines = []
    }
}
