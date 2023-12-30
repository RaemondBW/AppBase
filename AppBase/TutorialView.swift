//
//  TutorialView.swift
//  AppBase
//
//  Created by Raemond Bergstrom-Wood on 12/29/23.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Welcome to the Tutorial")
            // Add your tutorial content here
            Button("Finish Tutorial") {
                appState.hasCompletedTutorial = true
            }
        }
    }
}

// Preview for SwiftUI Canvas
struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView().environmentObject(AppState())
    }
}

