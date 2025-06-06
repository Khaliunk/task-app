# todo_list

Flutter task management app.

## Getting Started

 1. Ажлын жагсаалтын апп хийдэг үйлдлүүд

  - Таск нэмэх, шинэчлэх, устгах
  - Оффлайн горимд ажиллах
  - Хийгдээгүй таск ангилагдах
  - Синк хийгдэх

 2. Ажиллуулах 
  
  ```bash
  git clone https://github.com/Khaliunk/task-app.git
  cd task-app
  flutter pub get
  flutter run

 3.  Folder structure

  lib/
  ├── core/
  │    ├── utils/
  │    ├── constants/
  │    └── widgets/
  │
  ├── features/
  │    └── tasks/
  │         ├── data/
  │         ├── repo/
  │         └── presentation/
  │
  └── main.dart


  4. Ашигласан технологи

    - Flutter(SDK 3.29+)
    - Firebase (Firestore)
    - Riverpod (state management)
    - Hive (local storage)
