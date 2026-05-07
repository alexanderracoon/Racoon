//
//  AudioEnginePlayer.swift
//  Racoon
//
//  Created by Александр Переславцев on 04.05.2026.
//


import AVFoundation

///Объект Аудиодвижка
final class AudioEnginePlayer {
    // node.Play() когда есть материал для вспроизведения (scheduleFile)
    // scheduleFile ставить в очередь, но не начинает вспроизведение
    // engine.Start() запускает engine
    // engine.Pause() останавливает engine()
    // После eingine.Pause() нужно вызывать engine.Start()
    // eingineStop() останавливает engine и освобождает ресурсы
    // Без engine node.Play() не сработает
    // node.Pause() останавливает ноду, сохраняя состояние
    // node.Stop() очищает schedule и останавливает вспроизведение
    //
    // node.Stop() Вызывать при нажатии из FavoriteView, чтобы очитстить очередь
    // node.Pause() При вызове из PlabackView, чтобы поставить на паузу текущий трек
    // node.Play() Продолжает воспроизведение
    
    private let audioEngine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    
    private var audioFile: AVAudioFile?
    
    init() {
        setupEngine()
    }
    
    private func setupEngine() {
        // 1. Добавляем ноду в engine
        audioEngine.attach(playerNode)
        
        // 2. Соединяем с микшером
        audioEngine.connect(playerNode,
                       to: audioEngine.mainMixerNode,
                       format: nil)
        
        // 3. Запускаем audioEngine
        do {
            try audioEngine.start()
        } catch {
            print("Engine start error: \(error)")
        }
    }
    
    /// Загрузка файла
    func load(url: URL) {
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("File error: \(error)")
        }
    }
    
    /// Включение нового трека
    func play(url: URL) {
        load(url: url)
        guard let file = audioFile else { return }
        
        //Очистка плеера
        playerNode.stop()

        //MARK: - ДОБАВИТЬ АСИНХРОННОСТЬ
        //Прикрипление файла
        //The callback notifies your app when playback completes.
        playerNode.scheduleFile(file, at: nil) {
            /* Handle any work that's necessary after playback. */
        }
        
        do {
            try audioEngine.start()
            play()
        } catch {
            print(error.localizedDescription, "Error starting audio engine")
        }
    }
    
    /// Продолжает воспроизведение имеющего трека
    func play() {
        playerNode.play()
    }
    
    // Воспроизведение
    func play_old() {
        guard let file = audioFile else { return }
        
        playerNode.stop()
        
        //The callback notifies your app when playback completes.
        playerNode.scheduleFile(file, at: nil) {
            /* Handle any work that's necessary after playback. */
        }
        
        playerNode.play()
    }
    
    /// Пауза для текущей ноды
    func pause() {
        playerNode.pause()
    }
    
    /// Стоп для текущей ноды
    func stop() {
        playerNode.stop()
    }
}
