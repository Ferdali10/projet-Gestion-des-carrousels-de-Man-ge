#line 1 "C:/Users/USER/Desktop/project_man�ge/MyProject.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 4 "C:/Users/USER/Desktop/project_man�ge/MyProject.c"
sbit LCD_RS at RD5_bit;
sbit LCD_EN at RD4_bit;
sbit LCD_D4 at RD3_bit;
sbit LCD_D5 at RD2_bit;
sbit LCD_D6 at RD1_bit;
sbit LCD_D7 at RD0_bit;

sbit LCD_RS_Direction at TRISD5_bit;
sbit LCD_EN_Direction at TRISD4_bit;
sbit LCD_D4_Direction at TRISD3_bit;
sbit LCD_D5_Direction at TRISD2_bit;
sbit LCD_D6_Direction at TRISD1_bit;
sbit LCD_D7_Direction at TRISD0_bit;


char txt_speed[16];
char txt1[] = "BONJOUR AU";
char txt5[] = "  MANEGE  ";
char txt2[] = " PEUX COMMENCER";
char txt3[] = "EN COURS DU JEU";
char txt4[] = "JEU TERMINE";
char txt_consulter[] = "Consulter: ";
char txt_consulter_value[4];
unsigned int timerCount = 0;
unsigned int buzzer = 0;

unsigned int cnt = 0, x = 0, y = 0, i = 0 ;
unsigned int j = 0 ;
unsigned int n = 0;
unsigned int last_displayed_speed = 255;
unsigned int pot_value;
unsigned int motor_speed;
unsigned int failure_count = 0;

void interrupt() {
 if (INTCON.RBIF == 1) {
 if (PORTB.RB4 == 1)
 cnt = 1;
 else
 cnt = 0;

 if (PORTB.RB5 == 1)
 x = 1;
 else
 x = 0;

 if (PORTB.RB6 == 1)
 y = 1;
 else
 y = 0;

 if (PORTB.RB7 == 1)
 i = 1;
 else
 i = 0;

 if (cnt == 1 && x == 1 && y == 1 && i == 1)
 j = 1;
 else
 j = 0;

 INTCON.RBIF = 0;
 }

 if (INTCON.INTF == 1) {
 if (PORTB.RB0 == 1)
 n = 1;

 else
 n = 0;


 INTCON.INTF = 0;
 INTCON.INTE = 0;
 }

 if (INTCON.TMR0IF) {
 INTCON.TMR0IF = 0;
 TMR0 = 256 - 250;
 timerCount++;

 if (timerCount == 10) {
 buzzer = 1;
 }
 }
}
 void main() {
 TRISB = 0b11110001;
 TRISB.RB1=0;
 TRISC = 0xD0;
 TRISC.RC5 = 0;
 TRISD = 0;
 ADCON0 = 0;
 PORTC = 0;
 PORTD.RD6 = 0;
 OPTION_REG = 0b11000111;
 INTCON = 0b10011000;
 INTCON.TMR0IE = 1;
 TMR0 = 256 - 250;

 failure_count = EEPROM_Read( 0x00 );

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, txt1);
 Lcd_Out(2, 1, txt5);

 TRISA = 0b00000100;
 ADC_Init();

 while (1) {
 if (cnt == 1)
 PORTC.RC0 = 1;
 else
 PORTC.RC0 = 0;

 if (x == 1)
 PORTC.RC1 = 1;
 else
 PORTC.RC1 = 0;

 if (y == 1)
 PORTC.RC2 = 1;
 else
 PORTC.RC2 = 0;

 if (i == 1)
 PORTC.RC3 = 1;
 else
 PORTC.RC3 = 0;

 if (j == 1) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, txt2);
 delay_ms(1000);
 } else {
 j = 0;
 }

 if (n == 1) {
 timerCount = 0;
 INTCON.TMR0IE = 1;

 while (timerCount < 500) {
 j = 0;
 Lcd_Out(1, 1, txt3);

 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
 delay_ms(500);
 PORTC.RC0 = 1;
 PORTC.RC1 = 1;
 PORTC.RC2 = 1;
 PORTC.RC3 = 1;
 delay_ms(500);


 pot_value = ADC_Read(2);

 if (pot_value > 1000)
 pot_value = 1000;

 motor_speed = (pot_value * 100) / 600;


 Lcd_Out(2, 1, "Speed: ");
 IntToStr(motor_speed, txt_speed);
 Lcd_Out(2, 8, txt_speed);
 Lcd_Out(2, 14, "%");
 if (motor_speed > 0) {
 PWM1_Set_Duty((motor_speed * 255) / 100);
 } else {
 PWM1_Set_Duty(0);
 }
 while (motor_speed <= 20 && last_displayed_speed > 20) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "VITESSE LENTE");
 last_displayed_speed = motor_speed;
 Lcd_Out(2, 1, "Speed: ");
 Lcd_Out(2, 8, txt_speed);
 Lcd_Out(2, 14, "%");
 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
 delay_ms(500);
 PORTC.RC0 = 1;
 PORTC.RC1 = 1;
 PORTC.RC2 = 1;
 PORTC.RC3 = 1;
 delay_ms(500);
#line 203 "C:/Users/USER/Desktop/project_man�ge/MyProject.c"
 }
 while (motor_speed > 80 && last_displayed_speed <= 80) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "ALERTE VITESSE");
 Lcd_Out(2, 1, "Speed: ");
 Lcd_Out(2, 8, txt_speed);
 Lcd_Out(2, 14, "%");

 PORTC.RC5 = 1;
 delay_ms(2000);
 PORTC.RC5 = 0;
 last_displayed_speed = motor_speed;
 }
 if (PORTC.RC4 == 1) {
 PORTD.RD6 = 0;
 PORTD.RD7 = 1;
 delay_ms(200);
 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
 delay_ms(500);
 PORTC.RC0 = 1;
 PORTC.RC1 = 1;
 PORTC.RC2 = 1;
 PORTC.RC3 = 1;
 delay_ms(500);
 } else if (PORTC.RC4 == 0) {
 PORTD.RD6 = 1;
 PORTD.RD7 = 0;

 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
 delay_ms(500);
 PORTC.RC0 = 1;
 PORTC.RC1 = 1;
 PORTC.RC2 = 1;
 PORTC.RC3 = 1;
 delay_ms(500);
 }
 if (PORTB.RB0 == 0) {
 PORTD.RD6 = 0;
 PORTD.RD7 = 0;
 }
 while(PORTC.RC6==1){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "SYSTEME EN PANNE");
 PORTD.RD6 = 0;
 PORTD.RD7 = 0;
 PORTB.RB1=1;
 delay_ms(1000);
 PORTB.RB1=0;
 delay_ms(100);

 PORTC.RC5 = 1;
 delay_ms(2000);
 }

 }
 INTCON.TMR0IE = 0;

 buzzer = 1;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, txt4);
 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 0;
 PORTD.RD6 = 0;
 PORTD.RD7 = 0;
 } else {
 buzzer = 0;
 }

 if (buzzer == 1) {
 PORTC.RC5 = 1;
 delay_ms(2000);
 PORTC.RC5 = 0 ;
 delay_ms(200000);
 } else {
 PORTC.RC5 = 0;
 }
#line 302 "C:/Users/USER/Desktop/project_man�ge/MyProject.c"
 }
}
