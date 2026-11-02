# Đề 1: Ứng Dụng Quản Lý Công Việc (PRM393) - Mai Tiến Đạt

Dự án bài tập môn học PRM393 - Lập trình ứng dụng di động Flutter.

---

## 📋 Yêu Cầu Đề Bài & Mức Độ Hoàn Thành

| STT | Yêu cầu đề bài | Trạng thái | Chi tiết triển khai |
| :---: | :--- | :---: | :--- |
| **1** | Hiển thị danh sách công việc từ SQLite | ✅ Hoàn thành 100% | Tự động khởi tạo SQLite database và nạp sẵn 4 công việc mẫu chính xác theo đề bài khi khởi chạy lần đầu. Hỗ trợ hiển thị icon, tiêu đề, hạn chót/mô tả kèm biểu tượng lịch và nút chỉnh sửa. |
| **2** | Nhấn vào biểu tượng Edit chuyển sang màn hình chỉnh sửa và lưu thông tin | ✅ Hoàn thành 100% | Form chỉnh sửa với validation tiêu đề bắt buộc (`Tiêu đề *`), cho phép sửa mô tả, chuyển đổi trạng thái switch `Đã hoàn thành`, nút `Hủy` và nút `Lưu` cập nhật tức thì vào SQLite. |
| **3** | Cho phép lựa chọn màu AppBar (xanh dương, xanh lá, tím), lưu vào bộ nhớ | ✅ Hoàn thành 100% | Dialog chọn màu với 8 vòng tròn màu (trong đó có xanh dương, xanh lá, tím và các màu chủ đạo khác), hiển thị dấu tích trên màu đang chọn. Lưu trực tiếp qua `SharedPreferences`, mở lại app vẫn ghi nhớ màu đã chọn. |
| **4** | Tổ chức mã nguồn theo mô hình **MVVM**, sử dụng `riverpod` và `riverpod_generator` | ✅ Hoàn thành 100% | Tách biệt Model - View - ViewModel rõ ràng. Quản lý trạng thái bằng Riverpod kết hợp code generation (`riverpod_generator`, `build_runner`). |

---

## 🏛️ Cấu Trúc Mã Nguồn (Kiến Trúc MVVM)

```text
lib/
├── main.dart                          # Khởi tạo binding, FFI desktop, ProviderScope & runApp
├── models/
│   └── task_model.dart                # Model công việc (id, title, description, isCompleted, iconType)
├── data/
│   ├── database_helper.dart           # Quản lý SQLite database (CRUD công việc, khởi tạo mẫu ban đầu)
│   └── theme_preferences.dart         # Lưu trữ & đọc màu AppBar bằng SharedPreferences
├── viewmodels/
│   ├── task_viewmodel.dart            # ViewModel quản lý state công việc (danh sách, thêm, sửa, tìm kiếm)
│   ├── task_viewmodel.g.dart          # Code sinh tự động bởi riverpod_generator
│   ├── theme_viewmodel.dart           # ViewModel quản lý state màu AppBar
│   └── theme_viewmodel.g.dart         # Code sinh tự động bởi riverpod_generator
└── views/
    ├── screens/
    │   ├── task_list_screen.dart      # Màn hình chính danh sách công việc (Screen 1)
    │   └── edit_task_screen.dart      # Màn hình chỉnh sửa công việc (Screen 2)
    └── widgets/
        ├── task_item_card.dart        # Thẻ hiển thị từng công việc
        └── color_picker_dialog.dart   # Dialog chọn màu thanh ứng dụng (Screen 3)
```

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

### 1. Cài đặt các thư viện phụ thuộc:
```bash
flutter pub get
```

### 2. Sinh mã cho Riverpod (nếu cần sinh lại file `.g.dart`):
```bash
dart run build_runner build
```

### 3. Chạy ứng dụng:
- Trên thiết bị / máy ảo Android:
  ```bash
  flutter run
  ```
- Hoặc kiểm tra phân tích code:
  ```bash
  flutter analyze
  flutter test
  ```
