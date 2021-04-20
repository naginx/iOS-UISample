//
//  AgoraViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/03/23.
//

import UIKit

@objcMembers
final class AgoraViewController: UIViewController {

    private let appID = ""
    private let token = ""

    private var agoraKit: AgoraRtcEngineKit?
    private var agoraRtmKit: AgoraRtmKit?

    @IBOutlet weak private var remoteView: UIView!

    @IBOutlet weak private var localView: UIView!

    @IBAction func didTapHandUp(_ sender: UIButton) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAgoraEngine()
        setupLocalVideo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        joinChannel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leaveChannel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        AgoraRtcEngineKit.destroy()
        super.viewDidDisappear(animated)
    }

    // Agoraのインスタンスを生成
    func initializeAgoraEngine() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appID, delegate: self)
        agoraRtmKit = AgoraRtmKit(appId: appID, delegate: self)
    }

    // 自分側カメラと自分のViewを表示
    func setupLocalVideo() {
        agoraKit?.enableVideo()

        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localView
        videoCanvas.renderMode = .hidden

        agoraKit?.setupLocalVideo(videoCanvas)
    }

    // チャンネルに参加する
    func joinChannel() {
        agoraKit?.joinChannel(byToken: token,
                              channelId: "test",
                              info: nil,
                              uid: 0,
                              joinSuccess: { (channel, uid, elapsed) in
            print("Successfully joined channel \(channel)")
        })
        agoraRtmKit?.login(byToken: nil, user: "test", completion: { errorCode in
            if errorCode == AgoraRtmLoginErrorCode.ok {
                print("success Login")
            } else {
                print("failed Login")
            }
        })
    }

    // チャンネルを離れる
    func leaveChannel() {
        agoraKit?.leaveChannel(nil)
        agoraRtmKit?.logout(completion: { errorCode in
            if errorCode == AgoraRtmLogoutErrorCode.ok {
                print("success Logout")
            } else {
                print("failed Logout")
            }
        })
        localView.isHidden = true
        localView.isHidden = true
    }
}

extension AgoraViewController: AgoraRtcEngineDelegate {
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteView
        videoCanvas.renderMode = .hidden

        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}

extension AgoraViewController: AgoraRtmDelegate, AgoraRtmChannelDelegate {

}
