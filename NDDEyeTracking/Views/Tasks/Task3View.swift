//
//  Task3View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 28/5/21.
//

import SwiftUI
import Resolver
//import EyeTrackKit

private enum Task3Checkpoint {
    case instructions
    case task
    case complete
}

struct Task3View: View {
    @Binding var patient: Patient
    @Environment(\.presentationMode) var presentationMode // To programmatically dismiss view
    
    // View Models
    @EnvironmentObject var patientsViewModel: PatientsViewModel
    @EnvironmentObject var ettViewModel: ETTViewModel
    @ObservedObject var drawingTaskViewModel: DrawingTaskViewModel = DrawingTaskViewModel()
    
    // View Builder
    @State fileprivate var checkpoint: Task3Checkpoint = .instructions
    @State var instructionsSeconds: Int = Task3View.defaultInstructionsSeconds
    
    // Drawing Variables
    @State private var currentDrawing : Drawing = Drawing()
    @State private var drawings : [Drawing] = [Drawing]()
    @State private var color : Color = Color.black
    @State private var lineWidth : CGFloat = 3.0
    @State private var data = DrawingData()
    @State private var showPopup: Bool = false
    
    // Shape Variables
    @State var currentShapeNumber: Int = 0
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: EyeDataController = Resolver.resolve()
    
    init(patient: Binding<Patient>) {
        _patient = patient
        
        // Retrieve Eye Tracking Data
        let eyeTrackingData: EyeDataController = Resolver.resolve()
        self.eyeTrackController.onUpdate = { info in
            eyeTrackingData.addTrackingData(info: info!)
//            print(info?.centerEyeLookAtPoint ?? "nil")
        }
    }
    
    var body: some View {
        displayView()
            .onAppear {
                self.dataController.startRecording()
            }
            .navigationBarHidden(true)
    }
    
    // MARK: - View Builder
    @ViewBuilder
    private func displayView() -> some View {
        switch checkpoint {
        case .instructions: displayInstructions()
        case .task: displayDrawingTask()
        case .complete: displayCompleteTask()
        }
    }
    
    @ViewBuilder
    private func displayInstructions() -> some View {
        VStack {
            Text("TASK 3").font(.headline).bold()
            Text("Carefully trace the figure to the best of your ability.").font(.title)
        }
        .onReceive(timer, perform: { _ in
            self.startInstructionsTimer()
        })
    }
    
    @ViewBuilder
    private func displayDrawingTask() -> some View {
        
        // MARK: Eye Tracking View
        
        ZStack(alignment: .top) {
            ZStack(alignment: .topLeading) {
                self.eyeTrackController.view
                Circle()
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 15, height: 15)
                    .position(x: eyeTrackController.eyeTrack.lookAtPoint.x, y: eyeTrackController.eyeTrack.lookAtPoint.y)
            }
                .edgesIgnoringSafeArea(.all)
        }
        
        
        // MARK: Drawing Task View
        
        VStack {
            Spacer()
            Text("x: \(eyeTrackController.eyeTrack.lookAtPoint.x), y: \(eyeTrackController.eyeTrack.lookAtPoint.y)")
            ZStack {
                switch drawingTaskViewModel.shapes[currentShapeNumber].shape {
                case .archSpiral:
                    DrawingPadView(currentDrawing: $currentDrawing, drawings: $drawings)
                    ArchSpiral().stroke(lineWidth:3).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                case .spiroSquare:
                    DrawingPadView(currentDrawing: $currentDrawing, drawings: $drawings)
                    Spirograph().stroke(lineWidth:3).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                case .spiroGraph:
                    DrawingPadView(currentDrawing: $currentDrawing, drawings: $drawings)
                    Spirograph().stroke(lineWidth:3).opacity(0.5)
                    TouchCaptureView(currentDrawing: $currentDrawing, drawings: $drawings, data: $data).opacity(0.1)
                }
            }.padding()
            Button(action: {
                /*self.data.finishDrawing(patient : self.patient, drawingName: "trial" + trialnum.description + ".csv")*/
                print("current shape number: \(currentShapeNumber)")
                print(data.coordinates.count)
                
                if data.coordinates.count == 0 {
                    self.showPopup = true
                } else {
                    if currentShapeNumber < drawingTaskViewModel.shapes.count - 1 && !self.showPopup {
                        currentShapeNumber += 1
                        self.dataController.takeLap()
                        
                        // clear drawing and drawing coordinates from previous drawing
                        self.currentDrawing.points.removeAll()
                        self.drawings.removeAll()
                        self.data.coordinates.removeAll()
                    } else {
                        print("last shape")
                        /*self.drawings = [Drawing]()
                        self.data = DrawingData()*/
                        self.dataController.stopRecording()
                        self.drawingTaskViewModel.updateTrackingData(laps: self.dataController.laps, trackingData: self.dataController.eyeTrackData)
                        checkpoint = .complete
                    }
                }
            }, label: {
                if currentShapeNumber < drawingTaskViewModel.shapes.count - 1{
                    Text("Next Drawing").font(.system(size:30))
                } else {
                    Text("Finish Test").font(.system(size:30))
                }
            }).alert(isPresented: $showPopup, content: {
                return Alert(title: Text("No Drawing"), message: Text("Please follow the instructions and perform the drawing task to the best of your ability"), dismissButton: .default(Text("OK"), action: {
                    self.showPopup = false
                }))
            })
            Spacer()
        }.padding().frame(height: UIScreen.screenHeight)
    }
    
    @ViewBuilder
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Task 3").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(action: {
               ettViewModel.addTaskResult(key: TaskType.task3.rawValue, result: drawingTaskViewModel.shapes)
               patient.addTest(ett: ettViewModel.ett)
               presentationMode.wrappedValue.dismiss()
               patientsViewModel.persist()
           }) {
               Text("Finish Test")
           }.padding()
       }
    }
    
    
    // MARK: - Timer Constants
        
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultInstructionsSeconds: Int = 3
    
    // MARK: - Timer functions
    
    private func startInstructionsTimer() {
        if self.instructionsSeconds > 0 {
            self.instructionsSeconds -= 1
        } else {
            checkpoint = .task
        }
    }
}

struct Task3View_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
