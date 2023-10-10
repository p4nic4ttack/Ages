#ifndef POSITION_H
#define POSITION_H
#include <stdint.h>

typedef struct Position{
	int x;
	int y;
} Position;

void set_point(Position*, int, int);

void inc_x(Position*);
void dec_x(Position*);
void inc_y(Position*);
void dec_y(Position*);
#endif