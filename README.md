# 🍃 Mango Leaf Disease Detector

## 🌱 About the Project

Mango Leaf Disease Detector is a mobile application built using Flutter and TensorFlow Lite that leverages AI to classify mango leaf diseases using image recognition. The goal is to help farmers and agricultural professionals identify common diseases such as `Gall Midge`, `Sooty Mould`, and differentiate them from `Healthy leaves` with ease.

This application uses a custom-trained TensorFlow Lite model developed with `Teachable Machine`, trained on a small dataset of approximately 15 images per class.

## Screenshots
![thumbnail1](https://github.com/user-attachments/assets/acd03b4e-49f6-49b3-a06f-e77c48059dae)


## video


https://github.com/user-attachments/assets/d4aec528-c1bc-4679-9354-efec7bd441e2



## ✨ Features

- 📸 Pick image from camera or gallery
- 🤖 Classify mango leaf disease using TFLite model
- 📊 Display confidence scores in a chart
- 📄 Typing animated description about detected disease
- 📷 Displays related disease images
- 🎥 Embedded YouTube videos related to the disease
- 🔗 External article links for further reading
- 📱 Beautiful green-themed UI with animations and sliders
---

## 🧰 Packages Used

| Package Name              | Description                                           |
|---------------------------|-------------------------------------------------------|
| `cupertino_icons`         | iOS-style icons                                       |
| `google_fonts`            | Used Poppins for a modern UI font                    |
| `image_picker`            | Picking images from camera or gallery                |
| `tflite_flutter`          | Running TensorFlow Lite model inference              |
| `image`                   | Image preprocessing and decoding                     |
| `fl_chart`                | Drawing confidence bar charts                        |
| `collection`              | Helpers for collection manipulation                  |
| `url_launcher`            | To open external links in browser                    |
| `youtube_player_flutter`  | Embeds and plays YouTube videos inside app           |
| `animate_do`              | Provides beautiful entry animations                  |
| `carousel_slider`         | Creates an image carousel for visual engagement      |


## ✅ **Requirements**

    Flutter SDK: Latest stable version.

    Java JDK 17 or higher.

    VS Code or Android Studio.


## 🔧 Project Setup

### Prerequisites

Before you begin, make sure you have the following installed:

1. **Flutter SDK** (Version: 3.22.3 or higher)
   - To check if Flutter is installed, run:
     ```bash
     flutter --version
     ```
   - Example output:
     ```
     Flutter 3.22.3 • channel [user-branch] • unknown source
     Framework • revision b0850beeb2 (10 months ago) • 2024-07-16 21:43:41 -0700
     Engine • revision 235db911ba
     Tools • Dart 3.4.4 • DevTools 2.34.3
     ```

2. **Java Development Kit (JDK)** (Version 17 or higher)
   - Ensure that Java 17 is installed on your machine. You can verify it by running:
     ```bash
     java -version
     ```

3. **VS Code** (or any IDE of your choice)
   - Install **VS Code** for Flutter development.
   - Install the **Flutter** and **Dart** plugins in your IDE.

---

### 1. **Clone the Repository**

Once your development environment is ready, clone the repository to your local machine:

```bash
git clone https://github.com/subshegde/flutter-tflite-Image-classification.git
cd flutter-tflite-Image-classification
```

### 2. **Install Dependencies**

Run the following command to install the required dependencies:

```bash
flutter pub get

```


### 3. **Run the App**

Start the app by running the following command:
```bash
flutter run
```


### 4. **Checking for Issues with** `flutter doctor`

To ensure your Flutter environment is correctly set up, run the following command:

```bash
flutter doctor
```

# Happy Coding
