# VKStackImageView
This project uses ```CoreAnimation``` to mimic StackView from iOS. I have used ```UIImageView``` as the Base View for Stack. 


Usage is real simple. 
1) Drag and drop ```VKStackImageView.Swift``` in your project.
2) Add a variable like ```var vkView : VKStackImageView?``` in your ```UIViewController```.

3) In your ```viewDidLoad()```, add the following lines:

  ```vkView = VKStackImageView(imageNamesArray: ["dhoni.jpg","yuvi.jpg","shikhar.jpg","kohli.jpg"])```
  ```view.addSubview(vkView!)```

4) On ```buttonTapped``` function, add ```vkView?.toggleGallery()```.

That's it. You are done.


![vk](https://user-images.githubusercontent.com/21070922/39625622-dbc495de-4fbb-11e8-8b5b-2528aee618e9.gif)
