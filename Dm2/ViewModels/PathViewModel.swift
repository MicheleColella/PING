//  PathViewModel.swift


import Combine
import SwiftUI
import AVFoundation
import CoreHaptics

class PathViewModel: ObservableObject {
    
    @Published var isActive: Bool = false
    @Published var welcomeMessagePlayed: Bool = false
    @Published var selectedLine: Line?
    @Published var selectedStation: String?
    @Published var navigationTrigger = false
    @Published var shouldNavigateToStations = false

    let lines: [Line] = [
            Line(name: "Linea 1", stations: ["Garibaldi", "Piscinola"]),
            Line(name: "Linea 6", stations: ["Mostra", "Margellina"])
        ]

    init() {
        prepareHapticEngine()
        activateWelcomeMessage()
    }
    
    @Published var scale: CGFloat = 0.2
    @Published var destinationName: String = ""
    var timer: Timer?
    var currentPathIndex = 0
    var currentPath: Path?
    var synthesizer = AVSpeechSynthesizer()
    var hapticEngine: CHHapticEngine?
    
    func startPath(destinationName: String) {
        guard let path = PathRepository.shared.findPath(by: destinationName) else {
            print("Nessun percorso corrispondente trovato")
            return
        }
        
        self.destinationName = path.destinationName
        currentPath = path
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.updateCircleSize()
        }
    }
    
    func updateCircleSize() {
        if let path = currentPath {
            scale += 0.1
            if scale > 2.5 {
                scale = 0.2
                currentPathIndex += 1
                if currentPathIndex >= path.beacons.count {
                    self.resetPath()
                }
            } else {
                playHaptic()
            }
        }
    }
    
    func resetPath() {
        currentPathIndex = 0
        scale = 0.2
        timer?.invalidate()
        timer = nil
        speakDestinationReached()
    }
    
    func speakDestinationReached() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        let utterance = AVSpeechUtterance(string: "Siamo arrivati alla destinazione per \(destinationName)")
        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        synthesizer.speak(utterance)
    }
    
    func prepareHapticEngine() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
            print("Haptic engine started successfully.")
        } catch {
            print("Errore nell'inizializzazione del motore haptico: \(error)")
        }
    }
    
    func playHaptic() {
        guard let engine = hapticEngine else {
            print("Haptic engine is not available.")
            prepareHapticEngine()  // Tentativo di riavviare il motore haptico se non è disponibile
            return
        }

        let intensityValue = Float(scale / 2)
        let sharpnessValue = Float(scale)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpnessValue)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 0.4)

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
            print("Haptic event played with intensity \(intensityValue) and sharpness \(sharpnessValue).")
        } catch {
            print("Failed to play haptic feedback: \(error)")
        }
    }
    
    func activateWelcomeMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.isActive = true
            }
        }
    }
    
    func selectLine(_ line: Line) {
        selectedLine = line
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shouldNavigateToStations = true
        }
    }

    func selectStation(_ station: String) {
        selectedStation = station
        DispatchQueue.main.async {
            self.navigationTrigger = true
        }
    }

    func resetNavigation() {
        if navigationTrigger {
            navigationTrigger = false
            selectedLine = nil
            selectedStation = nil
        }
    }

}
