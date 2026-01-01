//
//  SectionHeaderAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// An Atom for section headers.
struct SectionHeaderAtom: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(.title3, design: .rounded, weight: .black))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}
