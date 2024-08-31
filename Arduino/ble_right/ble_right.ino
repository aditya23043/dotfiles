#include <SerialBT.h>

void setup() {
  SerialBT.setName("PicoW UPPERCASE 00:00:00:00:00:00");
  SerialBT.begin();
}

void loop() {
  while (SerialBT) {
    while (SerialBT.available()) {
      char c = SerialBT.read();
      c = toupper(c);
      SerialBT.write(c);
    }
  }
}
