#include "led_drv.h"

/*GPA 6 d2    GPA7 d3 */

void gpio_set_led(void)
{
  GPIO_InitTypeDef  GPIO_InitStructure;
  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6 | GPIO_Pin_7;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(GPIOA, &GPIO_InitStructure);

  GPIO_SetBits(GPIOA,GPIO_Pin_6 | GPIO_Pin_7);

}



/**
    *@author:         haobo.gao@qq.com
*@parameter:    led_snum:the led pin type hex,action:define in led.h
    *@return value:on success return 0,else -1
    *@describe :this is a led control function privode all the basic operate.
    *@BUG:not found.
*/
void led_ctl(uint16_t led_num,uint16_t action)
{
    switch(action)
	{
		case led_act_off: {
			GPIO_ResetBits(GPIOA,led_num);
		}break;

		case led_act_on:{
			GPIO_SetBits(GPIOA,led_num);
		}break;

		case led_act_trigger:{
			GPIOA->ODR ^= led_num;
		}break;

		default: ; break;
	}
}




