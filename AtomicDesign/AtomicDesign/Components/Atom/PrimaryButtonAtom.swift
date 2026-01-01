//
//  PrimaryButtonView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

import SwiftUI

struct PrimaryButtonAtom: View {
    var body: some View {
        VStack {
            Text("AA")
                .font(.system(size: 32, weight: .bold, design: .default))
        }
        .onTapGesture {
            //TODO:
        }
    }
}

#Preview {
    PrimaryButtonAtom()
}
