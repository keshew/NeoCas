import AVFoundation
import SwiftUI

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    
    private var bgPlayer: AVAudioPlayer?
    private var bingoPlayer: AVAudioPlayer?
    private var tapPlayer: AVAudioPlayer?
    private var slot3Player: AVAudioPlayer?
    
    @Published var volume: Float = 1 {
        didSet {
            bgPlayer?.volume = volume
            bingoPlayer?.volume = volume
            tapPlayer?.volume = volume
            slot3Player?.volume = volume
        }
    }
    
    @Published var isSoundEnabled: Bool = true
    @Published var isMusicEnabled: Bool = true
    
    private init() {
        loadSounds()
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func loadSounds() {
        bgPlayer = loadSound(resource: "bg", type: "wav", loops: -1)
        bingoPlayer = loadSound(resource: "bingo", type: "mp3")
        tapPlayer = loadSound(resource: "tap", type: "mp3")
        slot3Player = loadSound(resource: "slot3", type: "mp3")
    }
    
    private func loadSound(resource: String, type: String, loops: Int = 0) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: type) else {
            print("\(resource).\(type) не найден в bundle")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = loops
            player.volume = volume
            player.prepareToPlay()
            return player
        } catch {
            print("Ошибка загрузки \(resource): \(error)")
            return nil
        }
    }
    
    func playBackgroundMusic() {
        if isMusicEnabled {
            bgPlayer?.play()
        }
    }
    
    func stopBackgroundMusic() {
        bgPlayer?.stop()
    }
    
    func playBingo() { if isSoundEnabled { bingoPlayer?.play() } }
    func playTap() { if isSoundEnabled { tapPlayer?.play() } }
    func playSlot3() { if isSoundEnabled { slot3Player?.play() } }
    
    func stopAllSoundEffects() {
        bingoPlayer?.stop()
        tapPlayer?.stop()
        slot3Player?.stop()
    }
    
    @objc private func appWillResignActive() {
        stopBackgroundMusic()
        stopAllSoundEffects()
    }
    
    @objc private func appDidBecomeActive() {
        if isMusicEnabled {
            playBackgroundMusic()
        }
    }
    
    func toggleSound() {
        isSoundEnabled.toggle()
    }
    
    func toggleMusic() {
        isMusicEnabled.toggle()
        if isMusicEnabled {
            playBackgroundMusic()
        } else {
            stopBackgroundMusic()
        }
    }
}
