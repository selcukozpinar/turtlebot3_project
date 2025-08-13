# TurtleBot3 Controller & Simulation

Bu proje, **Flutter** ile geliştirilmiş bir TurtleBot3 kontrol uygulaması ile **ROS + Gazebo** tabanlı robot simülasyonunu bir araya getirir.  
Mobil uygulama joystick arayüzü üzerinden robotun hareketlerini kontrol eder.

---

## 📌 Özellikler
- 📱 Flutter tabanlı mobil kontrol uygulaması
- 🤖 ROS tabanlı TurtleBot3 simülasyonu
- 🌍 Gazebo 3D ortamında test imkanı
- 🔌 WebSocket/ROS Bridge üzerinden iletişim
- 📦 Kolay kurulabilir yapı

---

## 📂 Proje Yapısı
cd robot_code
catkin_make
source devel/setup.bash
roslaunch turtlebot3_gazebo turtlebot3_world.launch

---

## 🚀 Kurulum

### 1️⃣ Flutter Uygulaması
```bash
cd flutter_app
flutter pub get
flutter run

cd robot_code
catkin_make
source devel/setup.bash
roslaunch turtlebot3_gazebo turtlebot3_world.launch


🔧 Gereksinimler
Flutter SDK (3.x)

ROS Noetic (Ubuntu 20.04)

Gazebo 11

TurtleBot3 Paketi


🤝 Katkıda Bulunma
Bu projeyi fork edin

Yeni bir branch oluşturun (feature/yenilik)

Değişikliklerinizi commit edin

Branch’i push edin

Pull Request açın
