#include <pong.h>

const uint8_t pong_img[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0xf8, 0x98, 0x98, 0x98, 0x98, 0x98, 0xf0, 0x60, 0x00, 0x00, 0xe0, 0xf0, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0xf0, 0xe0, 0x00, 0x00, 0x00, 0xf8, 0xf8, 0x30, 0x60, 0xc0, 0x80, 0x00, 0x00, 0x00, 0xf8, 0xf8, 0x00, 0x00, 0x00, 0xe0, 0xf0, 0x18, 0x18, 0x18, 0x98, 0x98, 0x98, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x07, 0x0f, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x0f, 0x07, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x00, 0x01, 0x03, 0x06, 0x0c, 0x1f, 0x1f, 0x00, 0x00, 0x00, 0x07, 0x0f, 0x18, 0x18, 0x18, 0x19, 0x19, 0x19, 0x0f, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x1c, 0x1c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe7, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
const uint8_t pong_p1_wins[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0xf8, 0x98, 0x98, 0x98, 0x98, 0x98, 0xf0, 0x60, 0x00, 0x00, 0xf8, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf0, 0xf8, 0x9c, 0x86, 0x9c, 0xf8, 0xf0, 0x00, 0x00, 0x1c, 0x30, 0x60, 0xc0, 0xc0, 0x60, 0x30, 0x1c, 0x00, 0x00, 0xfc, 0xfc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0x00, 0x00, 0x00, 0xfc, 0xfc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0x78, 0x30, 0x00, 0x00, 0x00, 0x00, 0x10, 0x18, 0xfc, 0xfc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x01, 0x01, 0x1f, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x00, 0x00, 0x00, 0x03, 0x06, 0x0c, 0x18, 0x10, 0x00, 0x00, 0x00, 0x10, 0x18, 0x1f, 0x1f, 0x18, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfc, 0x00, 0x00, 0xec, 0xec, 0x00, 0x00, 0xfc, 0xfc, 0x18, 0x30, 0x60, 0xc0, 0x80, 0xfc, 0xfc, 0x00, 0x30, 0xfc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0x8c, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfc, 0x00, 0xfc, 0xfc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x07, 0x0c, 0x0c, 0x06, 0x06, 0x0c, 0x0c, 0x07, 0x03, 0x00, 0x00, 0x0f, 0x0f, 0x00, 0x00, 0x0f, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0f, 0x0f, 0x00, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x07, 0x03, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x0d, 0x00, 0x0d, 0x0d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
const uint8_t pong_p2_wins_diff1[] = {0x00, 0x38, 0x3c, 0x0e, 0x0e, 0x8e, 0x8e, 0xce, 0xfc, 0x38};
const uint8_t pong_p2_wins_diff2[] = {0x00, 0x00, 0x18, 0x1c, 0x1e, 0x1f, 0x19, 0x18, 0x18, 0x18};

void init_pong(Pong *pong){
	pong->ballX = (MATRIX_SIZE/2);
	pong->ballY = (MATRIX_SIZE/2);
	pong->player1Y = pong->player2Y = (MATRIX_SIZE/2);
	pong->ballSpeedX = 1;
    pong->ballSpeedY = 1;
    pong->playerSpeed = 1;
    pong->player1Score = 0;
    pong->player2Score = 0;
    pong->running = true;
    pong->delay = 150;
    pong->p1_scores = false;
    pong->p2_scores = false;
}

void update_game(Pong *pong) {
	if(!pong->p1_scores && !pong->p2_scores){
	    pong->ballX += pong->ballSpeedX;
	    pong->ballY += pong->ballSpeedY;
	    if (pong->ballY <= 0 || pong->ballY >= (MATRIX_SIZE - 1)) {
	        pong->ballSpeedY = -(pong->ballSpeedY);
	    }

	    if ((pong->ballX == 1 && pong->ballY >= pong->player1Y && pong->ballY < pong->player1Y + 3) ||
	        (pong->ballX == MATRIX_SIZE - 2 && pong->ballY >= pong->player2Y && pong->ballY < pong->player2Y + 3)) {
	        pong->ballSpeedX = -(pong->ballSpeedX);
	    }
	}
    if(pong->ballX <= 0){
    	if(pong->player1Score < 9){
    		pong->player1Score += 1;
    		pong->p1_scores = true;
    		pong->ballX = 13;
    		pong->ballY = pong->player2Y+1;
    		pong->ballSpeedY = 0;
    		pong->ballSpeedX = 0;
    	}else{
    		lcd_draw(pong_p1_wins, 0, 0, 504);
    		set_x(0);
    		set_y(0);
    		for(uint16_t i = 0; i < 164; i++){
    			lcd_data_byte(pong_img[i]);
    		}
    		pong->running = false;
    	}
    }
    if(pong->ballX >= MATRIX_SIZE - 1){
    	if(pong->player2Score < 9){
    		pong->player2Score += 1;
    		pong->p2_scores = true;
    		pong->ballX = 2;
    		pong->ballY = pong->player1Y + 1;
    		pong->ballSpeedY = 0;
    		pong->ballSpeedX = 0;
    	}else{
    		set_x(0);
    		set_y(0);
    		for(uint16_t i = 0; i < 504; i++){
    			if(i >= 236 && i <= 245){
    				lcd_data_byte(pong_p2_wins_diff1[i-236]);
    			}
    			else if(i >= 320 && i <= 329){
    				lcd_data_byte(pong_p2_wins_diff2[i-320]);
    			}else{
    				lcd_data_byte(pong_p1_wins[i]);
    			}
    		}
    		set_x(0);
    		set_y(0);
    		for(uint16_t i = 0; i < 164; i++){
    			lcd_data_byte(pong_img[i]);
    		}
    		pong->running = false;
    	}
    }
    if(pong->player1Score == 3 || pong->player2Score == 3){
    	pong->delay = 135;
    }
    if(pong->player1Score == 6 || pong->player2Score == 6){
    	pong->delay = 120;
    }
    if(pong->player1Score == 8 || pong->player2Score == 8){
    	pong->delay = 110;
    }
}

void render_pong(const Pong *pong){
	clear_framebuffer();
	char score_str_p1[3];
	char score_str_p2[3];
    sprintf(score_str_p1, "%d", pong->player1Score);
    sprintf(score_str_p2, "%d", pong->player2Score);
    lcd_out_str(score_str_p1, 30, 2);
    lcd_out_str(score_str_p2, 48, 2);
	for(uint8_t y = 0; y < MATRIX_SIZE; y++){
		for(uint8_t x = 0; x < MATRIX_SIZE; x++){
			if( (x == 1 && y >= pong->player1Y && y < pong->player1Y + 3) || (x == MATRIX_SIZE - 2 && y >= pong->player2Y && y < pong->player2Y + 3) ){
				set_pixel(x, y);
			}
			else if(x == pong->ballX && y == pong->ballY){
				set_pixel(x, y);
			}
		}
	}
	update_framebuffer(framebuffer);
}

void get_input_pong(Pong *pong){
	ButtonState up1 = up_pressed();
	ButtonState up2 = up2_pressed();
	ButtonState down1 = dwn_pressed();
	ButtonState down2 = dwn2_pressed();
	ButtonState a1 = a_pressed();
	ButtonState a2 = a2_pressed();
	if( (up1 == BTN_PRESSED && pong->player1Y > 0) || (up1 == BTN_HOLD && pong->player1Y > 0) ){
		pong->player1Y -= pong->playerSpeed;
	}
	if( (down1 == BTN_PRESSED && pong->player1Y < (MATRIX_SIZE - 3) ) || (down1 == BTN_HOLD && pong->player1Y < (MATRIX_SIZE - 3) ) ){
		pong->player1Y += pong->playerSpeed;
	}
	if( (up2 == BTN_PRESSED && pong->player2Y > 0) || (up2 == BTN_HOLD && pong->player2Y > 0) ){
		pong->player2Y -= pong->playerSpeed;
	}
	if( (down2 == BTN_PRESSED && pong->player2Y < (MATRIX_SIZE - 3) ) || (down2 == BTN_HOLD && pong->player2Y < (MATRIX_SIZE - 3) ) ){
		pong->player2Y += pong->playerSpeed;
	}

	if(pong->p1_scores){
		pong->ballX = 13;
		pong->ballY = pong->player2Y+1;
		if(a2 == BTN_PRESSED || a2 == BTN_HOLD){
			pong->ballSpeedY = ((rand() % 2)==0) ? 1 : -1;
			pong->ballSpeedX = -1;
			pong->p1_scores = false;
		}
	}
	if(pong->p2_scores){
		pong->ballX = 2;
		pong->ballY = pong->player1Y+1;
		if(a1 == BTN_PRESSED || a2 == BTN_HOLD){
			pong->ballSpeedY = ((rand() % 2)==0) ? 1 : -1;
			pong->ballSpeedX = 1;
			pong->p2_scores = false;
		}
	}

}

void main_pong_loop(void){
	Pong pong;
	init_pong(&pong);
	lcd_out_char(0xff);
	lcd_draw(pong_img, 0, 0, 504);
	while(pong.running){
		get_input_pong(&pong);
		update_game(&pong);
		get_input_pong(&pong);
		if(pong.running)
			render_pong(&pong);
		get_input_pong(&pong);
		for(uint8_t i = 0; i < pong.delay; i++)
			delay1ms();
	}
}