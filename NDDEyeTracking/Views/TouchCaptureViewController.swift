//
//  TouchCaptureViewController.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 27/6/21.
//

import UIKit

protocol TouchCaptureViewDelegate {
    func didStartDrag(_ sender : TouchCaptureViewController, _ touch : UITouch)
    func didDrag(_ sender : TouchCaptureViewController, _ touch : UITouch)
    func didFinishDrag(_ sender : TouchCaptureViewController, _ touch : UITouch)
}

class TouchCaptureViewController: UIViewController {
    
    var delegate : TouchCaptureViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with : event)
        if let touch = touches.first {
            delegate?.didStartDrag(self, touch)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            delegate?.didDrag(self, touch)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            delegate?.didFinishDrag(self, touch)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
