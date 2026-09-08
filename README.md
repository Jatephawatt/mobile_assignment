# 📱 Crypto Ranking Mobile App (`mobile_assignment_coin`)

แอปพลิเคชัน Flutter สำหรับแสดงผลอันดับและข้อมูลเหรียญคริปโตเคอร์เรนซี (Cryptocurrency) พร้อมฟีเจอร์การค้นหา, การแบ่งหน้า (Pagination / Infinite Scroll), Bottom Sheet รายละเอียดเหรียญ, แบนเนอร์ชวนเพื่อน (Invite Friends) และรองรับ Localization (en)

---

## 🚀 ฟีเจอร์หลัก (Features)

1. **Top 3 Coins Ranking**
   - แสดงการ์ด 3 เหรียญอันดับสูงสุดในแนวนอน (Symbol, Icon, Price, % Change Badge)
2. **Cryptocurrency List & Infinite Scroll**
   - ดึงข้อมูลเหรียญหน้าละ 10 รายการแบบ Infinite Scroll เมื่อเลื่อนถึงด้านล่าง
   - แสดงไอคอนเหรียญ (รองรับ SVG และ PNG), สัญลักษณ์ (Symbol), Market Cap (ฟอร์แมตตัวย่อ Trillion, Billion, Million), ราคาปัจจุบัน และ % การเปลี่ยนแปลง (สีเขียว/แดง พร้อมลูกศรขึ้น/ลง)
3. **Real-time Debounced Search**
   - ค้นหาเหรียญตามชื่อ (Name) หรือตัวย่อ (Symbol)
   - มี Debounce 1 วินาทีก่อนค้นหาเพื่อลดการเรียก API ซ้ำซ้อน
   - แสดง Empty State เมื่อไม่พบผลลัพธ์
   - มีปุ่มเคลียร์คำค้นหา (Clear button)
   - ปิด Pull-to-refresh อัตโนมัติขณะกำลังค้นหา
   - Search Bar ตรึงอยู่ด้านบนสุดตลอดเวลา (Fixed at the top)
4. **Pull to Refresh**
   - ลากลงเพื่อรีเฟรชข้อมูลเหรียญล่าสุด
5. **Coin Detail Bottom Sheet**
   - แตะที่เหรียญหรือการ์ด Top 3 เพื่อเปิด Bottom Sheet แสดงรายละเอียด (Icon, Name, Symbol, Price, Market Cap, Description)
   - ปุ่ม **GO TO WEBSITE** เปิดลิงก์เว็บไซต์ทางการของเหรียญผ่านบราวเซอร์ (`url_launcher`)
6. **Invite Friends Banner**
   - แบนเนอร์ชวนเพื่อนแทรกในรายการเหรียญตามระยะที่กำหนด (ทุกๆ 5 รายการ)
   - แตะเพื่อเปิด Native Share Sheet แชร์ลิงก์ไปยังแอปภายนอก (`share_plus`)
7. **Loading & Error Handling**
   - แสดง Loading Indicator ขณะกำลังดึงข้อมูลครั้งแรก
   - แสดง Loading Bar ด้านล่างขณะโหลดหน้าถัดไป (Pagination)
   - แสดงหน้าจอ Error พร้อมปุ่ม Retry เมื่อโหลดครั้งแรกไม่สำเร็จ
   - แสดงข้อความเตือนและปุ่ม Retry ด้านล่างเมื่อโหลดหน้าถัดไปไม่สำเร็จ
8. **Internationalization (Localization)**
   - รองรับภาษาอังกฤษ (`en`) ผ่าน `AppLocalizations`

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (Dart 3.x)
- **State Management & Architecture**: MVVM (Model-View-ViewModel) ด้วย [`provider`](https://pub.dev/packages/provider)
- **Networking**: [`dio`](https://pub.dev/packages/dio) & [`retrofit`](https://pub.dev/packages/retrofit)
- **Code Generation**: [`build_runner`](https://pub.dev/packages/build_runner), [`retrofit_generator`](https://pub.dev/packages/retrofit_generator), [`json_serializable`](https://pub.dev/packages/json_serializable)
- **UI / SVG**: [`flutter_svg`](https://pub.dev/packages/flutter_svg)
- **Formatting & Localization**: [`intl`](https://pub.dev/packages/intl), `flutter_localizations`
- **Native Platform Plugins**: [`url_launcher`](https://pub.dev/packages/url_launcher), [`share_plus`](https://pub.dev/packages/share_plus)

---

### 💡 เหตุผลในการเลือกใช้ Provider สำหรับ State Management (Justification)

ตามเกณฑ์การประเมิน (*"Preferred: state management with Bloc/Cubit (other approaches acceptable with justification)"*) โปรเจกต์นี้เลือกใช้ **Provider** ร่วมกับ **MVVM Pattern** ด้วยเหตุผลดังนี้:

1. **Pragmatic MVVM Architecture**:
   - `Provider` ร่วมกับ `ChangeNotifier` ช่วยให้การออกแบบตามสถาปัตยกรรม MVVM ทำได้อย่างตรงไปตรงมา โค้ดกระชับ อ่านง่าย และไม่มี Boilerplate ซับซ้อนเหมือน BLoC (ไม่ต้องสร้าง Event/State Class หลายๆ ไฟล์สำหรับ State ที่ตรงไปตรงมา)
2. **Flutter Official Endorsement**:
   - ได้รับการแนะนำอย่างเป็นทางการจากทีมงาน Flutter สำหรับการจัดการ State และ Dependency Injection ในแอปพลิเคชันระดับ Production
3. **Clean Separation of Concerns**:
   - แยกความรับผิดชอบอย่างชัดเจน:
     - **View**: รับผิดชอบเฉพาะการเรนเดอร์ UI และส่งต่อ Event (`CoinsScreen`, Widgets)
     - **ViewModel**: จัดการ State, Debounce Search, Pagination และ Business Logic (`CoinsViewModel`)
     - **Data / Service Layer**: จัดการการเชื่อมต่อ API (`CoinService`, `Retrofit`, `Dio`)
4. **Testability & Maintainability**:
   - `CoinsViewModel` สืบทอดมาจาก `ChangeNotifier` สามารถทำ Unit Test ทดสอบ Logic การโหลดข้อมูล, ค้นหา และ Pagination แยกต่างหากได้โดยไม่ต้องพึ่งพา Widget Tree หรือ context ที่ซับซ้อน


---

## 📁 โครงสร้างโปรเจกต์ (Project Structure)

```text
lib/
├── core/
│   ├── constants/
│   │   ├── api_constants.dart          # Base URL, endpoints, config ต่างๆ
│   │   └── app_colors.dart             # โค้ดสีประจำแอป
│   ├── localizations/
│   │   └── app_localizations.dart      # คลาสจัดการ Localization ภาษาอังกฤษ
│   └── utils/
│       └── formatter.dart              # จัดรูปแบบตัวเลข ราคา Market Cap และ % Change
├── models/
│   ├── coin_detail_response.dart       # Data model สำหรับ Coin Detail
│   └── coin_response_model.dart        # Data model สำหรับ Coins List
├── services/
│   ├── coin_service.dart               # Retrofit API Service & Dio Interceptor
│   └── coin_service.g.dart             # Generated code จาก Retrofit
├── viewModels/
│   └── coins_view_model.dart           # Business Logic, State, Search, Pagination, Share
├── views/
│   ├── screens/
│   │   └── coins_screen.dart           # หน้าจอหลัก (Coins Screen)
│   └── widgets/
│       ├── bottom_loading_widget.dart          # Loading indicator ด้านล่าง
│       ├── bottom_pagination_error_widget.dart # Error & Retry ตอนโหลดหน้าถัดไป
│       ├── change_badge_widget.dart            # Badge แสดง % Change
│       ├── coin_detail_bottom_sheet.dart       # Bottom Sheet รายละเอียดเหรียญ
│       ├── coin_icon_widget.dart               # ไอคอนเหรียญ (SVG & Network Image)
│       ├── coin_list_item.dart                 # แถวแสดงเหรียญแต่ละรายการ
│       ├── coin_search_bar.dart                # ช่องค้นหาเหรียญ
│       ├── empty_search_widget.dart            # หน้าจอเมื่อค้นหาไม่พบข้อมูล
│       ├── error_state_widget.dart             # หน้าจอ Error & ปุ่ม Retry
│       ├── invite_banner_widget.dart           # แบนเนอร์ชวนเพื่อน
│       ├── loading_state_widget.dart           # หน้าจอ Loading ตอนเปิดแอป
│       └── top_3_coins_widget.dart             # การ์ดแสดง Top 3 เหรียญ
└── main.dart                           # จุดเริ่มต้นแอปพลิเคชัน (App Entrypoint)
```

---

## ⚙️ ข้อกำหนดเบื้องต้น (Prerequisites)

- [Flutter SDK](https://docs.flutter.dev/get-started/install) เวอร์ชั่น **3.13.2** ขึ้นไป
- [Dart SDK](https://dart.dev/get-dart) เวอร์ชั่น **3.0.0** ขึ้นไป
- **Xcode** (สำหรับรันบน iOS Simulator / Device) หรือ **Android Studio** (สำหรับ Android Emulator / Device)

---

## 💻 วิธีติดตั้งและรันโปรเจกต์ (Getting Started)

### 1. ติดตั้ง Dependencies
เปิด Terminal ในโฟลเดอร์โปรเจกต์แล้วรันคำสั่ง:
```bash
flutter pub get
```

### 2. สร้างไฟล์ Code Generation (ถ้ามีการเปลี่ยนแปลง Model / API Service)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. รันแอปพลิเคชัน
เลือกรันบน Simulator / Emulator หรือเครื่องจริง:
```bash
# ตรวจสอบอุปกรณ์ที่เชื่อมต่ออยู่
flutter devices

# รันแอปพลิเคชัน
flutter run
```

---

## 🔑 การตั้งค่า API Key (Coinranking API via RapidAPI)

โปรเจกต์นี้ใช้งาน API จาก **Coinranking** ผ่านแพลตฟอร์ม **RapidAPI**

หากต้องการเปลี่ยน API Key หรือใช้งาน Key ของตนเอง สามารถแก้ไขได้ที่ไฟล์:
📁 `lib/services/coin_service.dart`

```dart
options.headers['x-rapidapi-key'] = 'YOUR_RAPIDAPI_KEY_HERE';
options.headers['x-rapidapi-host'] = 'coinranking1.p.rapidapi.com';
```

> **หมายเหตุ:** คุณสามารถสมัครสมาชิกและรับ API Key ฟรีได้ที่ [RapidAPI - Coinranking](https://rapidapi.com/coinranking/api/coinranking1)

---

## 🧪 การตรวจสอบคุณภาพโค้ด (Static Analysis)

สามารถรันคำสั่งเพื่อตรวจสอบความถูกต้องของไวยากรณ์และ lint rules:
```bash
dart analyze
```
