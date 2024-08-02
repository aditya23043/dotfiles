// LEFT HALF
#include <Keyboard.h>

#define rx_pin 1
#define tx_pin 0

char layout_alpha_1_key = '░';
char layout_alpha_2_key = '▒';
char layout_symbol_1_key = '▓';
char layout_symbol_2_key = '│';
char layout_num_key = '┤';
char layout_system_key = '╡';

char layout;

int pins[] = {
  18, 19, 20, 21,
  13, 12, 11, 10,
          14, 15
};
const int num_pins = sizeof(pins)/sizeof(pins[0]);

char key_down[num_pins];

char alpha_1[] = {
      layout_num_key,           'l', 'g', 'd',
                 'i',           's', 'r', 't',
  layout_alpha_2_key, KEY_BACKSPACE
};

char alpha_2[] = {
        KEY_ESC, 'v', 'w', 'm',
            'q', 'f', 'p', 'b',
  KEY_CAPS_LOCK, ' '
};

void setup() {

  Serial1.setRX(rx_pin);
  Serial1.setTX(tx_pin);
  Serial1.begin(9600);
  Serial1.setTimeout(50);

  Keyboard.begin();

  for(int i = 0; i < num_pins; i++){
    pinMode(pins[i], INPUT_PULLUP);
    key_down[i] = false;
  }

  pinMode(LED_BUILTIN, OUTPUT);

}

void loop() {

  layout = layout_alpha_1_key;
  for(int i = 0; i < num_pins; i++){
    if(digitalRead(pins[i]) == LOW){

      // ALPHA 2
      if(digitalRead(14) == LOW){
        layout = layout_alpha_2_key;
        if(!key_down[i] && alpha_1[i] != layout_alpha_2_key){
          Keyboard.write(alpha_2[i]);
        }
        key_down[i] = true;
      } 
      // ALPHA 1
      else {
        if(!key_down[i]){
          Keyboard.write(alpha_1[i]);
        }
        key_down[i] = true;
      }

    } else {
      key_down[i] = false;
    }
  }

  Serial1.write(layout);
  delay(10);

}
