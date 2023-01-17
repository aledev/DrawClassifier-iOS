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
    func classifyImage(_ displayScale: CGFloat, size: CGSize) {
        guard let drawClassifierService = drawClassifierService else {
            return
        }
        
        let renderer = ImageRenderer(
            content: DrawImageView(
                currentLine: self.currentLine,
                lines: self.lines
            )
            .frame(width: size.width, height: 500)
        )
        renderer.scale = displayScale
        
        guard let uiImage = renderer.uiImage,
              let data = uiImage.pngData(),
              let fullImage = UIImage(data: data),
              let resizedImage = fullImage.resizeTo(size: CGSize(width: 224, height: 224)) else {
            return
        }
                
        UIImageWriteToSavedPhotosAlbum(fullImage, nil, nil, nil)
        
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
