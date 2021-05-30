use actix_web::{get, post, web, App, HttpServer};
pub mod lib;

const PORT: i32 = 8000;
const ADDRESS: &str = "0.0.0.0";

// This struct represents state
struct DeviceState {
    device_name: String,
}

#[post("/on")]
async fn led_on() -> String {
    lib::turn_on_led();
    String::from("Lights are turned on")
}

#[post("/off")]
async fn led_off() -> String {
    lib::turn_off_led();
    String::from("Lights are turned off")
}

#[get("/")]
async fn index(data: web::Data<DeviceState>) -> String {
    let device_name = &data.device_name; 
    format!("You're logged into the device: {}!", device_name)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let socket_address = format!("{}:{}", ADDRESS, PORT);

    HttpServer::new(|| {
        App::new()
            .data(DeviceState {
                device_name: String::from("raspberri-pi"),
            })
            .service(index)
            .service(led_on)
            .service(led_off)
    })
    .bind(socket_address)?
    .run()
    .await
}
