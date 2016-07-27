//
//  NCursesWindow.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation
import CNCURSES

public class NCursesWindow: NCursesView {

    private lazy var keyPressTimer: Timer = {
        return Timer.scheduledTimer(0.02, repeats: true) { _ in
          self.keyPressTimerDidFire()
        }
    }()

    override var window: NCursesWindow? {
        return self
    }

    public init(frame: NRect) {

        super.init()

        self.frame = frame

        RunLoop.mainRunLoop().addTimer(keyPressTimer, forMode: RunLoopCommonModes)
    }

    override public func needsDisplay() {
        drawContext()

        subviews.forEach {
            $0.drawContext()
        }

        flushContext()
        refresh()
    }

    public func makeKeyAndVisible() {
        needsDisplay()
    }

    private func keyPressed() -> Bool {

        let pressedChracterCode = getch()

        if pressedChracterCode != ERR {
            ungetch(pressedChracterCode)
            return true
        } else {
            return false
        }
    }

    private func keyPressTimerDidFire() {

        guard keyPressed() else {
            return
        }

        let pressedCharacterCode = UInt32(getch())
        let characterScalar = UnicodeScalar(pressedCharacterCode)
        let character = Character(characterScalar)

        didPressKeyForCharacter(character: character)
    }
}
