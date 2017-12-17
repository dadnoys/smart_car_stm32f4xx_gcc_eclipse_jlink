#include "led_drv.h"
/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
void delay(unsigned int dec)
{
	int per;
	for(;dec>0;dec--){
		for(per = 2000;per>0;per--)	;
	}
}


int main(void)
{
  gpio_set_led();
  while (1)
  {
	  led_ctl(led_num_2,led_act_on);
	  led_ctl(led_num_1,led_act_off);
	  delay(2000);
	  led_ctl(led_num_2,led_act_off);
	  led_ctl(led_num_1,led_act_on);
	  delay(2000);
  }
}


