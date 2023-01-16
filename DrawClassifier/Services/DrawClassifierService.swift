//
//  DrawClassifierService.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import Foundation
import CoreML
import UIKit

class DrawClassifierService {
    // MARK: - Properties
    private var model: DrawClassifierV1? = nil
    
    // MARK: - Initializer
    init() {
        self.model = try? DrawClassifierV1(configuration: MLModelConfiguration())
    }
    
    // MARK: Deinit
    deinit {
        self.model = nil
    }
    
    // MARK: - Functions
    func classifyDraw(_ image: UIImage) -> String? {
        guard let model = model,
              let bufferImage = image.toBuffer() else {
            return nil
        }
        
        guard let output = try? model.prediction(image: bufferImage) else {
            return nil
        }
        
        return output.label
    }
}
