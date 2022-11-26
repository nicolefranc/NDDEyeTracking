//
//  RecordingView.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 11/26/22.
//

import SwiftUI
import AVKit

struct RecordingView: View {
    @State private var timer = 5
    @State private var onComplete = false
    @State private var recording = false
    
    var body: some View {
        ZStack {
            VideoRecordingView(timeLeft: $timer, onComplete: $onComplete, recording: $recording)
            VStack {
                Text("RecordingView")
                Button(action: {self.recording.toggle()}, label: {
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 65, height: 65)

                        Circle()
                            .stroke(Color.black,lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                })
                Button(action: {
                    self.timer -= 1
                    print(self.timer)
                }, label: {
                    Text("Toggle timer")
                })
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    self.onComplete.toggle()
                }, label: {
                    Text("Toggle completion")
                })
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
    
}

struct VideoRecordingView: UIViewRepresentable {
    
    @Binding var timeLeft: Int
    @Binding var onComplete: Bool
    @Binding var recording: Bool
    
    func makeUIView(context: UIViewRepresentableContext<VideoRecordingView>) -> PreviewView {
        let recordingView = PreviewView()
        recordingView.onComplete = {
            self.onComplete = true
        }
        recordingView.onRecord = { timeLeft, totalShakes in
            self.timeLeft = timeLeft
            self.recording = true
        }
        
        recordingView.onReset = {
            self.recording = false
            self.timeLeft = 30
        }
        return recordingView
    }
    
    func updateUIView(_ uiViewController: PreviewView, context: UIViewRepresentableContext<VideoRecordingView>) {
        if recording {
            uiViewController.start()
        }
    }
}

extension PreviewView: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print(outputFileURL.absoluteString)
    }
}

class PreviewView: UIView {
    private var captureSession: AVCaptureSession?
    private var shakeCountDown: Timer?
    let videoFileOutput = AVCaptureMovieFileOutput()
    var recordingDelegate:AVCaptureFileOutputRecordingDelegate!
    var recorded = 0
    var secondsToReachGoal = 5
    
    var onRecord: ((Int, Int)->())?
    var onReset: (() -> ())?
    var onComplete: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        
        var allowedAccess = false
        let blocker = DispatchGroup()
        blocker.enter()
        AVCaptureDevice.requestAccess(for: .video) { flag in
            allowedAccess = flag
            blocker.leave()
        }
        blocker.wait()
        
        if !allowedAccess {
            print("!!! NO ACCESS TO CAMERA")
            return
        }
        
        // setup session
        let session = AVCaptureSession()
        session.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .front)
        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
            print("!!! NO CAMERA DETECTED")
            return
        }
        session.addInput(videoDeviceInput)
        session.commitConfiguration()
        self.captureSession = session
    }
    
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        recordingDelegate = self
    }
    
    func start() {
        startTimers()
        if nil != self.superview {
            self.videoPreviewLayer.session = self.captureSession
            self.videoPreviewLayer.videoGravity = .resizeAspect
            self.captureSession?.startRunning()
            self.startRecording()
        } else {
            self.captureSession?.stopRunning()
        }
    }
    
    private func onTimerFires(){
        print("🟢 RECORDING \(videoFileOutput.isRecording)")
        secondsToReachGoal -= 1
        recorded += 1
        onRecord?(secondsToReachGoal, recorded)
        
        if(secondsToReachGoal == 0){
            stopRecording()
            shakeCountDown?.invalidate()
            shakeCountDown = nil
            onComplete?()
            videoFileOutput.stopRecording()
        }
    }
    
    func startTimers(){
        if shakeCountDown == nil {
            shakeCountDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
                self?.onTimerFires()
            }
        }
    }
    
    func startRecording(){
        captureSession?.addOutput(videoFileOutput)
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsURL.appendingPathComponent("tempPZDC")
        
        videoFileOutput.startRecording(to: filePath, recordingDelegate: recordingDelegate)
    }
    
    func stopRecording(){
        videoFileOutput.stopRecording()
        print("🔴 RECORDING \(videoFileOutput.isRecording)")
    }
}
