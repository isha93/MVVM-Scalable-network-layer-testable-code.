//
//  TypeListMolecule.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct TypeListMolecule: View {
    let types: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(types, id: \.self) { type in
                TypeBadgeAtom(type: type)
            }
        }
    }
}
