//
//  DrawCanvasView.swift
//  DrawClassifier
//
//  Created by Alejandro Ignacio Aliaga Martinez on 16/1/23.
//

import SwiftUI

struct DrawCanvasView: View {
    // MARK: - Properties
    @Binding var currentLine: Line
    @Binding var lines: [Line]
    
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
            .gesture(
                DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .local
                )
                .onChanged { value in
                    currentLine.points.append(value.location)
                    lines.append(currentLine)
                }
                .onEnded { value in
                    self.lines.append(currentLine)
                    self.currentLine = Line()
                }
            ) //: DragGesture
            
        } //: VStack
        
    } //: Body
    
}

// MARK: - Preview
struct Previews_DrawCanvasView: PreviewProvider {
    
    static var previews: some View {
        
        // Light Theme
        DrawCanvasView(
            currentLine: .constant(Line()),
            lines: .constant([Line]())
        )
        .preferredColorScheme(.light)
        
        // Dark Theme
        DrawCanvasView(
            currentLine: .constant(Line()),
            lines: .constant([Line]())
        )
        .preferredColorScheme(.dark)
        
    }
    
}
