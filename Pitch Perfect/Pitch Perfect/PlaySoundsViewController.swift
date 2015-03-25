//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stefan Spaar on 3/17/15.
//  Copyright (c) 2015 Stefan Spaar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        // introduced to make audio louder on iPhone
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetAudio()    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

    func playByRate(rate: Float)   {
        resetAudio()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudiowithVariablePitch(pitch: Float) {
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func playAudiowithDelay(delay: Float) {
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        var audioEchoNode = AVAudioUnitDelay()
        audioEchoNode.delayTime = NSTimeInterval(delay)
        audioEngine.attachNode(audioEchoNode)
        
        audioEngine.connect(audioPlayerNode, to: audioEchoNode, format: nil)
        audioEngine.connect(audioEchoNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlow(sender: UIButton) {
        println("Playing Slow")
        resetAudio()
        playByRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        println("Playing Fast")
        resetAudio()
        playByRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("Playing Chipmunk")
        resetAudio()
        playAudiowithVariablePitch(1000)

    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        println("Playing DarthVader")
        resetAudio()
        playAudiowithVariablePitch(-1000)
  
    }
    
    @IBAction func playEcho(sender: UIButton) {
        println("Playing Echo Effect")
        resetAudio()
        playAudiowithDelay(0.5)
    }
    
    @IBAction func playReverb(sender: UIButton) {
        println("Playing Reverb Effect")
        resetAudio()
        playAudiowithDelay(0.06)
    }
    
    @IBAction func audioStop(sender: UIButton) {
        println("Audio stop")
        resetAudio()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
