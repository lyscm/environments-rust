use rust_gpiozero::*;

const PIN: u8 = 17;

pub fn turn_on_led() {
    let led = LED::new(PIN);
    led.on();
}

pub fn turn_off_led() {
    let led = LED::new(PIN);
    led.off();
}
