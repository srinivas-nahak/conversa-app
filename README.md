![Conversa_App_Header](https://github.com/srinivas-nahak/conversa-app/assets/24781014/56edca75-d5d6-4ff6-9b3f-9bae6c53f6a2)


## Description
A Firebase integrated messaging app where users can create accounts and log in for an engaging messaging experience. It also has custom animations created in After Effects and integrated into the app using Lottie/Rive. It is made with Flutter, Material Design 3 using the recommended <a href="https://docs.flutter.dev/resources/architectural-overview">Flutter Architecture Guidelines</a>.

## Challenges
- Integration of Firebase functions for push notification didn't happen with the npm install, thus I had to use "npm install -g yarn"
- The widget sizes and spacing were too arbitrary for different devices, so I optimized using the "responsive_resizer" plugin. Instead of just using "EdgeInsets.all(double)" I used "EdgeInsets.symmetric(horizontal: value.w, vertical: value.h)" for having a more symmetric feel.
- Lottie's documentation for dynamic editing of animations was faulty so after several experiments I was able to edit the Lottie animations during runtime.
Ex- Documentation code
**`ValueDelegate
  .position( const ['Shape Layer 1', 'Rectangle', '**'],
            relative: const Offset(100, 200),
          ),`**

My code
**`ValueDelegate
  .transformPosition( const ['Rectangle', '**'],
            relative: const Offset(100, 200),
          ),`**


## Screenshots

![Conversa_App_Multiple_Screens](https://github.com/srinivas-nahak/conversa-app/assets/24781014/98699215-7653-48f7-a9d8-6d5aae3f4e42)



## Demo

https://github.com/srinivas-nahak/conversa-app/assets/24781014/f70476a3-d017-4b06-8b7d-2c5eb7ba6c66



## Features
- [x] User creation and authentication using Firebase.
- [x] Customised vector animations using After Effects and Lottie.
- [x] Enhanced message bubbles for a better user experience.
- [x] Subtle transition and button animations.
- [x] Push notifications on message send.
- [x] Enabled image uploading for user DP.
- [x] A visually responsive and aesthetic User Experience.



## Main Plugins Used
Plugin Name    
:-------------------------|
|firebase(multiple plugins)
|lottie
|responsive_sizer
|image_picker

## License

Bmi App is distributed under the terms of the MIT License. See the
[license](LICENSE) for more information.
