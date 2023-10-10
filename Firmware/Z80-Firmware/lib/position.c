#include <position.h>

void set_point(Position *pos, int x, int y){
	if(x >= 0 && x < 16)
		pos->x = x;
	if(y >= 0 && y < 16)
		pos->y = y;
}


void inc_x(Position *p){
	int x = p->x + 1;
	set_point(p,x,p->y);
}

void dec_x(Position *p){
	int x = p->x - 1;
	set_point(p,x,p->y);
}

void inc_y(Position *p){
	int y = p->y + 1;
	set_point(p,p->x,y);
}

void dec_y(Position *p){
	int y = p->y - 1;
	set_point(p,p->x,y);
}