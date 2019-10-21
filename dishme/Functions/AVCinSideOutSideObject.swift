
import UIKit
import AVFoundation
import Photos


class AVCinSideOutSideObject: NSObject {
    
    //キャプチャセッションに入力（オーディオやビデオなど）を提供し、ハードウェア固有のキャプチャ機能のコントロールを提供するデバイス。
    var captureDevice  = AVCaptureDevice.default(for: .video)
    var stillImageOutput: AVCapturePhotoOutput? //静止画、ライブ写真、その他の写真ワークフローの出力をキャプチャします。
    
    private var baseZoomFanctor: CGFloat = 1.0
    
    
    func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceDescoverySession =
            
            AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                  mediaType: AVMediaType.video,
                                                  position: AVCaptureDevice.Position.unspecified)
        
        for device in deviceDescoverySession.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    func initscreen(){
        self.captureDevice = self.cameraWithPosition(.front)!
    }
    
    func inSideOutSideCameraSet(cameraView: UIImageView ) -> UIImageView {
        //キャプチャデバイスからキャプチャセッションにメディアを提供するキャプチャ入力。
        var input: AVCaptureDeviceInput!
        stillImageOutput = AVCapturePhotoOutput()
        // キャプチャアクティビティを管理し、入力デバイスからキャプチャ出力へのデータフローを調整するオブジェクト。
        let captureSesion = AVCaptureSession()
        // 解像度の設定
        captureSesion.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        if cameraView.frame.width != 0 {
            //一連の構成変更の開始を示します。
            captureSesion.beginConfiguration()
            //一連の構成変更をコミットします。
            captureSesion.commitConfiguration()
        }
        
        if captureDevice?.position == .front {
            UIView.transition(with: cameraView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.captureDevice = self.cameraWithPosition(.back)!
            }, completion: nil)
        } else {
            UIView.transition(with: cameraView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.captureDevice = self.cameraWithPosition(.front)!
            }, completion: nil)
        }
        
        var deviceInput: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
            deviceInput = try AVCaptureDeviceInput(device: captureDevice!)
            // 入力
            if  captureSesion.canAddInput(deviceInput) {
                captureSesion.removeInput(input)
                captureSesion.addInput(deviceInput)
                // 出力
                if (captureSesion.canAddOutput(stillImageOutput!)) {
                    captureSesion.addOutput(stillImageOutput!)
                    // カメラ起動
                    captureSesion.startRunning()
                    
                    //キャプチャされているときにビデオを表示できるコアアニメーションレイヤ-
                    var previewLayer: AVCaptureVideoPreviewLayer?
                    //キャプチャされているときにビデオを表示できるコアアニメーションレイヤ-
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSesion)
                    // アスペクトフィット
                    previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    // カメラの向き
                    previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    previewLayer?.frame =  cameraView.frame
                    return cameraView
                }
            }
        } catch {
            print(error)
            
        }
        return cameraView
    }
    
    //シャッターを撮影するメソッド
    func cameraAction (captureDelegate:AVCapturePhotoCaptureDelegate) {
        // フラッシュとかカメラの設定
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        // キャプチャが自動イメージ安定化を使用するかどうかを指定するブール値。
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        // アクティブなデバイスでサポートされている最高解像度で静止画像をキャプチャするかどうかを指定するブール値。
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        // 撮影
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: captureDelegate)
    }
    
    func setupPinchGestureRecognizer(addview: UIView) {
        // pinch recognizer for zooming
        let pinchGestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.onPinchGesture(_:)))
        addview.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    @objc private func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            self.baseZoomFanctor = (self.captureDevice?.videoZoomFactor)!
        }
        
        let tempZoomFactor: CGFloat = self.baseZoomFanctor * sender.scale
        let newZoomFactdor: CGFloat
        if tempZoomFactor < (self.captureDevice?.minAvailableVideoZoomFactor)! {
            newZoomFactdor = (self.captureDevice?.minAvailableVideoZoomFactor)!
        } else if (self.captureDevice?.maxAvailableVideoZoomFactor)! < tempZoomFactor {
            newZoomFactdor = (self.captureDevice?.maxAvailableVideoZoomFactor)!
        } else {
            newZoomFactdor = tempZoomFactor
        }
        
        do {
            try self.captureDevice?.lockForConfiguration()
            self.captureDevice?.ramp(toVideoZoomFactor: newZoomFactdor, withRate: 32.0)
            self.captureDevice?.unlockForConfiguration()
        } catch {
            print("Failed to change zoom factor.")
        }
    }
}
