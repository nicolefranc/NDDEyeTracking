//
//  ImageTaskView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct ImageTaskView: View {
    private let images: [String] = ["penguin", "snail", "field"]
    
    @State private var currentImgIdx: Int = 0
    @State private var seconds: Int = ImageTaskView.defaultSeconds
    @State private var shouldNavigate: Bool = false
    
    
    var body: some View {
        Image(images[currentImgIdx])
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .onReceive(timer, perform: { _ in
                self.timerActions()
            })
        NavigationLink(
            destination: TestOverview(checkpoint: .endTask1),
            isActive: $shouldNavigate) { EmptyView() }
    }
    
    // MARK: - Timer Constants
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultSeconds: Int = 3
    
    // MARK: - Timer functions
    
    private func timerActions() {
        if self.seconds == 0 {
            if (self.currentImgIdx < self.images.count - 1) {
                self.currentImgIdx += 1
                self.seconds = ImageTaskView.defaultSeconds
            } else {
                self.timer.upstream.connect().cancel()
                self.shouldNavigate = true
            }
        } else {
            self.seconds -= 1
        }
    }
}

struct ImageTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTaskView()
    }
}
