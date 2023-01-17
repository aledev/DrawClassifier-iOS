//
//  DrawImageView.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import SwiftUI

struct DrawImageView: View {
    // MARK: - Properties
    let currentLine: Line
    let lines: [Line]
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            Canvas { context, size in
                
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    
                    context.stroke(
                        path,
                        with: .color(line.color),
                        lineWidth: line.lineWidth
                    )
                    
                }
                
            } //: Canvas           
            
        } //: VStack
        
    } //: Body
    
}
