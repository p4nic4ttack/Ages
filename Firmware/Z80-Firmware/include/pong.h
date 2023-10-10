#ifndef PONG_H
#define PONG_H

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <joystick.h>
#include <ws2812-matrix.h>
#include <lcd.h>

typedef struct Pong{
	int ballX, ballY;
	int player1Y, player2Y;
	int ballSpeedX, ballSpeedY;
	uint8_t playerSpeed;
	uint8_t player1Score;
	uint8_t player2Score;
	uint8_t delay;
	bool running;

	bool p1_scores;
	bool p2_scores;
} Pong;

void init_pong(Pong*);
void update_game(Pong*);
void render_pong(const Pong*);
void get_input_pong(Pong*);
void main_pong_loop(void);


#endif