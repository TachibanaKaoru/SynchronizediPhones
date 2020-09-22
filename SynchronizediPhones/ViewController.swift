//
//  ViewController.swift
//  SynchronizediPhones
//
//  Created by Kaoru Tachibana on 2020/09/22.
//

import UIKit
import RealityKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    var videoMaterial: VideoMaterial?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load ManyBlackDevice
        let manyBlackDevice = try! ManyBlackDevice.loadBox()
        arView.scene.anchors.append(manyBlackDevice)
        
        // action on device tap
        manyBlackDevice.actions.tapPhone1.onAction = {entity in
            
            print("(device tapped.)")
            
            self.videoMaterial?.avPlayer?.play()
            
            let mesh = MeshResource.generateBox(width: 0.125, height: 0.01, depth: 0.065)
            let videoEntity = ModelEntity(mesh: mesh, materials: [self.videoMaterial!])
            
            entity?.addChild(videoEntity)
            
        }
        
        // make video material
        if let url = Bundle.main.url(forResource: "hello", withExtension: "mp4"){
            
            let item = AVPlayerItem(asset: AVAsset(url: url))
            let player = AVPlayer(playerItem: item)
            videoMaterial = VideoMaterial(avPlayer: player)
            
        }

    }
}
