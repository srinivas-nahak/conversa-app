![Conversa_App_Header](https://github.com/srinivas-nahak/conversa-app/assets/24781014/56edca75-d5d6-4ff6-9b3f-9bae6c53f6a2)


## Description
An elegant cross-platform weather forecast app with custom UI that shows the 5-day forecast. It is made with Flutter, Material Design 3 using the recommended <a href="https://docs.flutter.dev/resources/architectural-overview">Flutter Architecture Guidelines</a>.

## Screenshots

![Conversa_App_Multiple_Screens](https://github.com/srinivas-nahak/conversa-app/assets/24781014/98699215-7653-48f7-a9d8-6d5aae3f4e42)



## Demo

https://github.com/srinivas-nahak/conversa-app/assets/24781014/f70476a3-d017-4b06-8b7d-2c5eb7ba6c66


## Key Achievements
* Integrated push notifications using yarn for improved performance.
* Enabled image uploading for showing the user display picture.
* Customized message bubbles for enhanced visual appeal and user experience.
* Created animations in After Effects, exported with Lottie
* Dynamically edited the Lottie animations during runtime.
* Implemented subtle animations throughout the app like transitions, button clicks, etc.

## Challenges
- Integration of Firebase functions for push notification didn't happen with the npm install, thus I had to use "npm install -g yarn"
- The widget sizes and spacing were too arbitrary for different devices, so optimized it using the "responsive_resizer" plugin. Instead of just using "EdgeInsets.all(double)" I used "EdgeInsets.symmetric(horizontal: value.w, vertical: value.h)" for having a more symmetric feel.



## Plugins Used
Plugin Name    
:-------------------------|
|geolocator
|http
|flutter_riverpod
|shared_preferences
|flutter_svg
|intl

## License

Bmi App is distributed under the terms of the MIT License. See the
[license](LICENSE) for more information.
