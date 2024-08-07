// RIGHT HALF
#include <Keyboard.h>

#define rx_pin 1
#define tx_pin 0

char foo;

char layout_alpha_1_key = '░';
char layout_alpha_2_key = '▒';
char layout_symbol_1_key = '▓';
char layout_symbol_2_key = '│';
char layout_num_key = '┤';
char layout_system_key = '╡';

int pins[] = {
  10, 11, 12, 13,
  21, 20, 19, 18,
  16, 17
};
const int num_pins = sizeof(pins)/sizeof(pins[0]);

char key_down[num_pins];

char alpha_1[] = {
  'h', 'u', 'o', layout_system_key,
  'n', 'e', 'a', 'c',
  ' ', layout_alpha_2_key
};

char alpha_2[] = {
  'k', '\'', 'z', '"',
  'j', ',', 'x', 'y',
  KEY_CAPS_LOCK, KEY_TAB
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

  for(int i = 0; i < num_pins; i++){
    if(digitalRead(pins[i]) == LOW){
      
      // ALPHA 2
      foo = Serial1.read();
      if(foo == layout_alpha_2_key){
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

  delay(10);

}
