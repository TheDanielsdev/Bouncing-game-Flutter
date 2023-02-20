// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:doodle_dash/game/sprites/sprites.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../doodle_dash.dart';
import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  bool get isMobile => !kIsWeb;
  // Mobile Support: Add isMobile boolean
  Player? plai;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: ScoreDisplay(game: widget.game),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: ElevatedButton(
              child: isPaused
                  ? const Icon(
                      Icons.play_arrow,
                      size: 48,
                    )
                  : const Icon(
                      Icons.pause,
                      size: 48,
                    ),
              onPressed: () {
                (widget.game as DoodleDash).togglePauseState();
                setState(
                  () {
                    isPaused = !isPaused;
                    // isMobile = Platform.isAndroid || Platform.isIOS;
                  },
                );
              },
            ),
          ),
          // Mobile Support: Add on-screen left & right directional buttons
          if (isMobile)
            Positioned(
                bottom: 40,
                right: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: [
                    GestureDetector(
                        onLongPress: () {
                          plai!.isMobileLeft();
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    GestureDetector(
                        onLongPress: () {
                          plai!.isMobileRight();
                        },
                        child: Icon(Icons.arrow_forward_ios))
                  ],
                )),
          if (!kIsWeb && isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2,
              right: MediaQuery.of(context).size.width / 2,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
