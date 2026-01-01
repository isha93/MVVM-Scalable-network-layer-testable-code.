//
//  FlowLayout.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height = rows.last?.maxY ?? 0
        return CGSize(width: proposal.width ?? 0, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        for row in rows {
            for element in row.elements {
                element.subview.place(at: CGPoint(x: bounds.minX + element.x, y: bounds.minY + element.y), proposal: proposal)
            }
        }
    }
    
    struct Row {
        var elements: [Element] = []
        var y: CGFloat = 0
        var height: CGFloat = 0
        var maxY: CGFloat { y + height }
    }
    
    struct Element {
        let subview: LayoutSubview
        let x: CGFloat
        let y: CGFloat
    }
    
    func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [Row] {
        var rows: [Row] = []
        var currentRow = Row()
        var x: CGFloat = 0
        var y: CGFloat = 0
        let maxWidth = proposal.width ?? 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width > maxWidth && !currentRow.elements.isEmpty {
                y += currentRow.height + spacing
                rows.append(currentRow)
                currentRow = Row(y: y, height: 0)
                x = 0
            }
            
            currentRow.elements.append(Element(subview: subview, x: x, y: y))
            currentRow.height = max(currentRow.height, size.height)
            x += size.width + spacing
        }
        
        if !currentRow.elements.isEmpty {
            rows.append(currentRow)
        }
        
        return rows
    }
}
