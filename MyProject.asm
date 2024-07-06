
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,38 :: 		void interrupt() {
;MyProject.c,39 :: 		if (INTCON.RBIF == 1) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt0
;MyProject.c,40 :: 		if (PORTB.RB4 == 1)
	BTFSS      PORTB+0, 4
	GOTO       L_interrupt1
;MyProject.c,41 :: 		cnt = 1;
	MOVLW      1
	MOVWF      _cnt+0
	MOVLW      0
	MOVWF      _cnt+1
	GOTO       L_interrupt2
L_interrupt1:
;MyProject.c,43 :: 		cnt = 0;
	CLRF       _cnt+0
	CLRF       _cnt+1
L_interrupt2:
;MyProject.c,45 :: 		if (PORTB.RB5 == 1)
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt3
;MyProject.c,46 :: 		x = 1;
	MOVLW      1
	MOVWF      _x+0
	MOVLW      0
	MOVWF      _x+1
	GOTO       L_interrupt4
L_interrupt3:
;MyProject.c,48 :: 		x = 0;
	CLRF       _x+0
	CLRF       _x+1
L_interrupt4:
;MyProject.c,50 :: 		if (PORTB.RB6 == 1)
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt5
;MyProject.c,51 :: 		y = 1;
	MOVLW      1
	MOVWF      _y+0
	MOVLW      0
	MOVWF      _y+1
	GOTO       L_interrupt6
L_interrupt5:
;MyProject.c,53 :: 		y = 0;
	CLRF       _y+0
	CLRF       _y+1
L_interrupt6:
;MyProject.c,55 :: 		if (PORTB.RB7 == 1)
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt7
;MyProject.c,56 :: 		i = 1;
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
	GOTO       L_interrupt8
L_interrupt7:
;MyProject.c,58 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
L_interrupt8:
;MyProject.c,60 :: 		if (cnt == 1 && x == 1 && y == 1 && i == 1)
	MOVLW      0
	XORWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt74
	MOVLW      1
	XORWF      _cnt+0, 0
L__interrupt74:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
	MOVLW      0
	XORWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt75
	MOVLW      1
	XORWF      _x+0, 0
L__interrupt75:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
	MOVLW      0
	XORWF      _y+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt76
	MOVLW      1
	XORWF      _y+0, 0
L__interrupt76:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt77
	MOVLW      1
	XORWF      _i+0, 0
L__interrupt77:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
L__interrupt69:
;MyProject.c,61 :: 		j = 1;
	MOVLW      1
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
	GOTO       L_interrupt12
L_interrupt11:
;MyProject.c,63 :: 		j = 0;
	CLRF       _j+0
	CLRF       _j+1
L_interrupt12:
;MyProject.c,65 :: 		INTCON.RBIF = 0; // Clear the Port B change interrupt flag
	BCF        INTCON+0, 0
;MyProject.c,66 :: 		}
L_interrupt0:
;MyProject.c,68 :: 		if (INTCON.INTF == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt13
;MyProject.c,69 :: 		if (PORTB.RB0 == 1)
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt14
;MyProject.c,70 :: 		n = 1;
	MOVLW      1
	MOVWF      _n+0
	MOVLW      0
	MOVWF      _n+1
	GOTO       L_interrupt15
L_interrupt14:
;MyProject.c,73 :: 		n = 0;
	CLRF       _n+0
	CLRF       _n+1
L_interrupt15:
;MyProject.c,76 :: 		INTCON.INTF = 0; // Clear the external interrupt flag
	BCF        INTCON+0, 1
;MyProject.c,77 :: 		INTCON.INTE = 0; // Disable external interrupt
	BCF        INTCON+0, 4
;MyProject.c,78 :: 		}
L_interrupt13:
;MyProject.c,80 :: 		if (INTCON.TMR0IF) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt16
;MyProject.c,81 :: 		INTCON.TMR0IF = 0; // Clear Timer 0 interrupt flag
	BCF        INTCON+0, 2
;MyProject.c,82 :: 		TMR0 = 256 - 250; // Reload Timer 0 for a 1-second delay
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,83 :: 		timerCount++;
	INCF       _timerCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _timerCount+1, 1
;MyProject.c,85 :: 		if (timerCount == 10) {
	MOVLW      0
	XORWF      _timerCount+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt78
	MOVLW      10
	XORWF      _timerCount+0, 0
L__interrupt78:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt17
;MyProject.c,86 :: 		buzzer = 1; // Activate the buzzer on RC5
	MOVLW      1
	MOVWF      _buzzer+0
	MOVLW      0
	MOVWF      _buzzer+1
;MyProject.c,87 :: 		}
L_interrupt17:
;MyProject.c,88 :: 		}
L_interrupt16:
;MyProject.c,89 :: 		}
L_end_interrupt:
L__interrupt73:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,90 :: 		void main() {
;MyProject.c,91 :: 		TRISB = 0b11110001; // Configure RB4..RB7 as input
	MOVLW      241
	MOVWF      TRISB+0
;MyProject.c,92 :: 		TRISB.RB1=0;
	BCF        TRISB+0, 1
;MyProject.c,93 :: 		TRISC = 0xD0;
	MOVLW      208
	MOVWF      TRISC+0
;MyProject.c,94 :: 		TRISC.RC5 = 0;
	BCF        TRISC+0, 5
;MyProject.c,95 :: 		TRISD = 0;
	CLRF       TRISD+0
;MyProject.c,96 :: 		ADCON0 = 0;          // Disable ADC
	CLRF       ADCON0+0
;MyProject.c,97 :: 		PORTC = 0;
	CLRF       PORTC+0
;MyProject.c,98 :: 		PORTD.RD6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,99 :: 		OPTION_REG = 0b11000111; // Timer 0 with 256 prescaler, falling edge trigger, 8-bit mode
	MOVLW      199
	MOVWF      OPTION_REG+0
;MyProject.c,100 :: 		INTCON = 0b10011000;     // GIE, PEIE, RBIE, INTEDG
	MOVLW      152
	MOVWF      INTCON+0
;MyProject.c,101 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;MyProject.c,102 :: 		TMR0 = 256 - 250;
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,104 :: 		failure_count = EEPROM_Read(EEPROM_FAILURE_COUNT_ADDRESS);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _failure_count+0
	CLRF       _failure_count+1
;MyProject.c,106 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,107 :: 		Lcd_Cmd(_LCD_CLEAR);       // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,108 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,109 :: 		Lcd_Out(1, 1, txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,110 :: 		Lcd_Out(2, 1, txt5);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,112 :: 		TRISA = 0b00000100; // Configure RA2 (AN2) as input for potentiometer
	MOVLW      4
	MOVWF      TRISA+0
;MyProject.c,113 :: 		ADC_Init();
	CALL       _ADC_Init+0
;MyProject.c,115 :: 		while (1) {
L_main18:
;MyProject.c,116 :: 		if (cnt == 1)
	MOVLW      0
	XORWF      _cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      1
	XORWF      _cnt+0, 0
L__main80:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;MyProject.c,117 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
	GOTO       L_main21
L_main20:
;MyProject.c,119 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
L_main21:
;MyProject.c,121 :: 		if (x == 1)
	MOVLW      0
	XORWF      _x+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main81
	MOVLW      1
	XORWF      _x+0, 0
L__main81:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;MyProject.c,122 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
	GOTO       L_main23
L_main22:
;MyProject.c,124 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
L_main23:
;MyProject.c,126 :: 		if (y == 1)
	MOVLW      0
	XORWF      _y+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main82
	MOVLW      1
	XORWF      _y+0, 0
L__main82:
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProject.c,127 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
	GOTO       L_main25
L_main24:
;MyProject.c,129 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
L_main25:
;MyProject.c,131 :: 		if (i == 1)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVLW      1
	XORWF      _i+0, 0
L__main83:
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;MyProject.c,132 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
	GOTO       L_main27
L_main26:
;MyProject.c,134 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
L_main27:
;MyProject.c,136 :: 		if (j == 1) {
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVLW      1
	XORWF      _j+0, 0
L__main84:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;MyProject.c,137 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,138 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,139 :: 		Lcd_Out(1, 1, txt2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,140 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
	NOP
	NOP
;MyProject.c,141 :: 		} else {
	GOTO       L_main30
L_main28:
;MyProject.c,142 :: 		j = 0;
	CLRF       _j+0
	CLRF       _j+1
;MyProject.c,143 :: 		}
L_main30:
;MyProject.c,145 :: 		if (n == 1) {
	MOVLW      0
	XORWF      _n+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVLW      1
	XORWF      _n+0, 0
L__main85:
	BTFSS      STATUS+0, 2
	GOTO       L_main31
;MyProject.c,146 :: 		timerCount = 0;
	CLRF       _timerCount+0
	CLRF       _timerCount+1
;MyProject.c,147 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;MyProject.c,149 :: 		while (timerCount < 500) {
L_main32:
	MOVLW      1
	SUBWF      _timerCount+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVLW      244
	SUBWF      _timerCount+0, 0
L__main86:
	BTFSC      STATUS+0, 0
	GOTO       L_main33
;MyProject.c,150 :: 		j = 0;
	CLRF       _j+0
	CLRF       _j+1
;MyProject.c,151 :: 		Lcd_Out(1, 1, txt3);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,153 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,154 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,155 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,156 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,157 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
	NOP
;MyProject.c,158 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,159 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;MyProject.c,160 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,161 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;MyProject.c,162 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject.c,165 :: 		pot_value = ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _pot_value+0
	MOVF       R0+1, 0
	MOVWF      _pot_value+1
;MyProject.c,167 :: 		if (pot_value > 1000)
	MOVF       R0+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main87
	MOVF       R0+0, 0
	SUBLW      232
L__main87:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;MyProject.c,168 :: 		pot_value = 1000;
	MOVLW      232
	MOVWF      _pot_value+0
	MOVLW      3
	MOVWF      _pot_value+1
L_main36:
;MyProject.c,170 :: 		motor_speed = (pot_value * 100) / 600;
	MOVF       _pot_value+0, 0
	MOVWF      R0+0
	MOVF       _pot_value+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      88
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _motor_speed+0
	MOVF       R0+1, 0
	MOVWF      _motor_speed+1
;MyProject.c,173 :: 		Lcd_Out(2, 1, "Speed: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,174 :: 		IntToStr(motor_speed, txt_speed);
	MOVF       _motor_speed+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _motor_speed+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt_speed+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,175 :: 		Lcd_Out(2, 8, txt_speed);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_speed+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,176 :: 		Lcd_Out(2, 14, "%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,177 :: 		if (motor_speed > 0) {
	MOVF       _motor_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main88
	MOVF       _motor_speed+0, 0
	SUBLW      0
L__main88:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;MyProject.c,178 :: 		PWM1_Set_Duty((motor_speed * 255) / 100);
	MOVF       _motor_speed+0, 0
	MOVWF      R0+0
	MOVF       _motor_speed+1, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,179 :: 		} else {
	GOTO       L_main38
L_main37:
;MyProject.c,180 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,181 :: 		}
L_main38:
;MyProject.c,182 :: 		while (motor_speed <= 20 && last_displayed_speed > 20) {
L_main39:
	MOVF       _motor_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main89
	MOVF       _motor_speed+0, 0
	SUBLW      20
L__main89:
	BTFSS      STATUS+0, 0
	GOTO       L_main40
	MOVF       _last_displayed_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main90
	MOVF       _last_displayed_speed+0, 0
	SUBLW      20
L__main90:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
L__main71:
;MyProject.c,183 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,184 :: 		Lcd_Out(1, 1, "VITESSE LENTE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,185 :: 		last_displayed_speed = motor_speed;
	MOVF       _motor_speed+0, 0
	MOVWF      _last_displayed_speed+0
	MOVF       _motor_speed+1, 0
	MOVWF      _last_displayed_speed+1
;MyProject.c,186 :: 		Lcd_Out(2, 1, "Speed: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,187 :: 		Lcd_Out(2, 8, txt_speed);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_speed+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,188 :: 		Lcd_Out(2, 14, "%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,189 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,190 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,191 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,192 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,193 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;MyProject.c,194 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,195 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;MyProject.c,196 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,197 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;MyProject.c,198 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	DECFSZ     R11+0, 1
	GOTO       L_main44
	NOP
	NOP
;MyProject.c,203 :: 		}*/
	GOTO       L_main39
L_main40:
;MyProject.c,204 :: 		while (motor_speed > 80 && last_displayed_speed <= 80) {
L_main45:
	MOVF       _motor_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main91
	MOVF       _motor_speed+0, 0
	SUBLW      80
L__main91:
	BTFSC      STATUS+0, 0
	GOTO       L_main46
	MOVF       _last_displayed_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main92
	MOVF       _last_displayed_speed+0, 0
	SUBLW      80
L__main92:
	BTFSS      STATUS+0, 0
	GOTO       L_main46
L__main70:
;MyProject.c,205 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,206 :: 		Lcd_Out(1, 1, "ALERTE VITESSE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,207 :: 		Lcd_Out(2, 1, "Speed: ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,208 :: 		Lcd_Out(2, 8, txt_speed);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt_speed+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,209 :: 		Lcd_Out(2, 14, "%");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,211 :: 		PORTC.RC5 = 1;
	BSF        PORTC+0, 5
;MyProject.c,212 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;MyProject.c,213 :: 		PORTC.RC5 = 0;
	BCF        PORTC+0, 5
;MyProject.c,214 :: 		last_displayed_speed = motor_speed;
	MOVF       _motor_speed+0, 0
	MOVWF      _last_displayed_speed+0
	MOVF       _motor_speed+1, 0
	MOVWF      _last_displayed_speed+1
;MyProject.c,215 :: 		}
	GOTO       L_main45
L_main46:
;MyProject.c,216 :: 		if (PORTC.RC4 == 1) {
	BTFSS      PORTC+0, 4
	GOTO       L_main50
;MyProject.c,217 :: 		PORTD.RD6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,218 :: 		PORTD.RD7 = 1;
	BSF        PORTD+0, 7
;MyProject.c,219 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main51:
	DECFSZ     R13+0, 1
	GOTO       L_main51
	DECFSZ     R12+0, 1
	GOTO       L_main51
	DECFSZ     R11+0, 1
	GOTO       L_main51
	NOP
;MyProject.c,220 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,221 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,222 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,223 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,224 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main52:
	DECFSZ     R13+0, 1
	GOTO       L_main52
	DECFSZ     R12+0, 1
	GOTO       L_main52
	DECFSZ     R11+0, 1
	GOTO       L_main52
	NOP
	NOP
;MyProject.c,225 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,226 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;MyProject.c,227 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,228 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;MyProject.c,229 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main53:
	DECFSZ     R13+0, 1
	GOTO       L_main53
	DECFSZ     R12+0, 1
	GOTO       L_main53
	DECFSZ     R11+0, 1
	GOTO       L_main53
	NOP
	NOP
;MyProject.c,230 :: 		} else if (PORTC.RC4 == 0) {
	GOTO       L_main54
L_main50:
	BTFSC      PORTC+0, 4
	GOTO       L_main55
;MyProject.c,231 :: 		PORTD.RD6 = 1;
	BSF        PORTD+0, 6
;MyProject.c,232 :: 		PORTD.RD7 = 0;
	BCF        PORTD+0, 7
;MyProject.c,234 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,235 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,236 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,237 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,238 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	DECFSZ     R12+0, 1
	GOTO       L_main56
	DECFSZ     R11+0, 1
	GOTO       L_main56
	NOP
	NOP
;MyProject.c,239 :: 		PORTC.RC0 = 1;
	BSF        PORTC+0, 0
;MyProject.c,240 :: 		PORTC.RC1 = 1;
	BSF        PORTC+0, 1
;MyProject.c,241 :: 		PORTC.RC2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,242 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;MyProject.c,243 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	DECFSZ     R11+0, 1
	GOTO       L_main57
	NOP
	NOP
;MyProject.c,244 :: 		}
L_main55:
L_main54:
;MyProject.c,245 :: 		if (PORTB.RB0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_main58
;MyProject.c,246 :: 		PORTD.RD6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,247 :: 		PORTD.RD7 = 0;
	BCF        PORTD+0, 7
;MyProject.c,248 :: 		}
L_main58:
;MyProject.c,249 :: 		while(PORTC.RC6==1){
L_main59:
	BTFSS      PORTC+0, 6
	GOTO       L_main60
;MyProject.c,250 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,251 :: 		Lcd_Out(1, 1, "SYSTEME EN PANNE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,252 :: 		PORTD.RD6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,253 :: 		PORTD.RD7 = 0;
	BCF        PORTD+0, 7
;MyProject.c,254 :: 		PORTB.RB1=1;
	BSF        PORTB+0, 1
;MyProject.c,255 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main61:
	DECFSZ     R13+0, 1
	GOTO       L_main61
	DECFSZ     R12+0, 1
	GOTO       L_main61
	DECFSZ     R11+0, 1
	GOTO       L_main61
	NOP
	NOP
;MyProject.c,256 :: 		PORTB.RB1=0;
	BCF        PORTB+0, 1
;MyProject.c,257 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main62:
	DECFSZ     R13+0, 1
	GOTO       L_main62
	DECFSZ     R12+0, 1
	GOTO       L_main62
	NOP
	NOP
;MyProject.c,259 :: 		PORTC.RC5 = 1;     // Activate the buzzer on RC5
	BSF        PORTC+0, 5
;MyProject.c,260 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main63:
	DECFSZ     R13+0, 1
	GOTO       L_main63
	DECFSZ     R12+0, 1
	GOTO       L_main63
	DECFSZ     R11+0, 1
	GOTO       L_main63
	NOP
	NOP
;MyProject.c,261 :: 		}
	GOTO       L_main59
L_main60:
;MyProject.c,263 :: 		}
	GOTO       L_main32
L_main33:
;MyProject.c,264 :: 		INTCON.TMR0IE = 0; // Disable Timer 0 interrupt after 10 seconds
	BCF        INTCON+0, 5
;MyProject.c,266 :: 		buzzer = 1; // Activate the buzzer on RC5
	MOVLW      1
	MOVWF      _buzzer+0
	MOVLW      0
	MOVWF      _buzzer+1
;MyProject.c,268 :: 		Lcd_Cmd(_LCD_CLEAR);       // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,269 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,270 :: 		Lcd_Out(1, 1, txt4);       // Display "JEU TERMINÉ"
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,271 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;MyProject.c,272 :: 		PORTC.RC1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,273 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,274 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,275 :: 		PORTD.RD6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,276 :: 		PORTD.RD7 = 0;
	BCF        PORTD+0, 7
;MyProject.c,277 :: 		} else {
	GOTO       L_main64
L_main31:
;MyProject.c,278 :: 		buzzer = 0;
	CLRF       _buzzer+0
	CLRF       _buzzer+1
;MyProject.c,279 :: 		}
L_main64:
;MyProject.c,281 :: 		if (buzzer == 1) {
	MOVLW      0
	XORWF      _buzzer+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main93
	MOVLW      1
	XORWF      _buzzer+0, 0
L__main93:
	BTFSS      STATUS+0, 2
	GOTO       L_main65
;MyProject.c,282 :: 		PORTC.RC5 = 1;     // Activate the buzzer on RC5
	BSF        PORTC+0, 5
;MyProject.c,283 :: 		delay_ms(2000);   // Delay for 10 seconds
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main66:
	DECFSZ     R13+0, 1
	GOTO       L_main66
	DECFSZ     R12+0, 1
	GOTO       L_main66
	DECFSZ     R11+0, 1
	GOTO       L_main66
	NOP
	NOP
;MyProject.c,284 :: 		PORTC.RC5 = 0 ;
	BCF        PORTC+0, 5
;MyProject.c,285 :: 		delay_ms(200000);
	MOVLW      4
	MOVWF      R10+0
	MOVLW      247
	MOVWF      R11+0
	MOVLW      154
	MOVWF      R12+0
	MOVLW      154
	MOVWF      R13+0
L_main67:
	DECFSZ     R13+0, 1
	GOTO       L_main67
	DECFSZ     R12+0, 1
	GOTO       L_main67
	DECFSZ     R11+0, 1
	GOTO       L_main67
	DECFSZ     R10+0, 1
	GOTO       L_main67
	NOP
;MyProject.c,286 :: 		} else {
	GOTO       L_main68
L_main65:
;MyProject.c,287 :: 		PORTC.RC5 = 0;
	BCF        PORTC+0, 5
;MyProject.c,288 :: 		}
L_main68:
;MyProject.c,302 :: 		}
	GOTO       L_main18
;MyProject.c,303 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
