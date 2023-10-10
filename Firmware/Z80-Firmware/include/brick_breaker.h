#ifndef BRICKBREAKER_H
#define BRICKBREAKER_H

#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <ws2812-matrix.h>
#include <joystick.h>
#include <lcd.h>


#define MATRIX_SIZE 16
typedef struct {
    uint8_t x;
    uint8_t y;
    bool active;
} Brick;

typedef struct {
    uint8_t x;
    uint8_t y;
    int dx;
    int dy;
} Ball;

typedef struct {
    uint8_t x;
} Paddle;

void init_brickbreaker(Brick bricks[], Ball *ball, Paddle *paddle);
void main_brickbreaker_loop();
void draw(Brick bricks[], const Ball *ball, const Paddle *paddle);
void get_input_brickbreaker(Paddle *paddle);
void shift_bricks_left(Brick bricks[]);
void shift_bricks_right(Brick bricks[]);
void move_ball(Ball *ball, const Paddle *paddle);
void check_collision_brickbreaker(Brick bricks[MATRIX_SIZE], Ball *ball, int *score);
/*bool check_win(Brick bricks[MATRIX_SIZE][MATRIX_SIZE]);*/

#endif