/*
 *	write by haobo @ZhengZhou
 *							2017Äê12ÔÂ17ÈÕ12:08:52
 *
 * stm32f4xx	simple led driver's head file
 */
#include "stm32f4xx.h"



#define led_num_1			GPIO_Pin_6
#define led_num_2			GPIO_Pin_7
#define led_act_on			11
#define led_act_off			12
#define led_act_trigger		13

void led_ctl(uint16_t led_num,uint16_t action);
void gpio_set_led(void);


