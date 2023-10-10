#ifndef SNAKE_H
#define SNAKE_H
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <position.h>
#include <joystick.h>
#include <ws2812-matrix.h>
#include <lcd.h>

typedef enum Direction{
    D_UP,
    D_DOWN,
    D_LEFT,
    D_RIGHT
} Direction;

typedef struct Snake{
    Position body[MATRIX_SIZE * MATRIX_SIZE];
    uint16_t length;
    uint16_t prev_length;
    Direction direction;
    bool game_over;
    bool update_lvl;
} Snake;

typedef struct Food{
    Position position;
    bool active;
} Food;

void main_snake_loop();
void init_snake(Snake *snake, Food *food);
void draw_board(const Snake *snake, const Food *food);
void get_input(Direction *direction);
void move_snake(Snake *snake);
bool check_collision(const Snake *snake);
void place_food(Food *food, const Snake *snake);

#endif