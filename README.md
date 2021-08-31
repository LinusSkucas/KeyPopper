# KeyPopper
Popping sounds for your keyboard!

🌀 🍿 Have you ever wanted a nice popping sound whenever you typed something? But how about not just on a website, how about **system wide**? How about something that’s _over-engineered_? 

🎹 Well now you can thanks to KeyPopper. With my new service, your computer will spit out popping, mooing, or frogy soundy thingys, whenever you type something. 
It comes packaged as a preference pane, but what’s really ~trojaned~ in there is:
 - 1 Preference Pane that uses XPC to communicate to…
 - 1 XPC service that is registered as a launch agent (triggered by a mach service) and manages preference storage and communicates to…
 - Another XPC service registered as a launch agent (triggered by a mach service) that makes popping noises
 - Finally a keystroke catcher app that runs on login, and communicates keystrokes to the first XPC service! It uses some nasty CGEvent and Accessibility APIs.
📦 Everything is stored nicely in the preference pane. The only other things installed are launch agent files. 🎁

🦩This has past apple’s notarization, meaning it’s pretty good.

This was a bunch of fun learning about low level macOS stuff. Anyways, you can see the source code over on GitHub: https://github.com/LinusS1/KeyPopper
And you can install it using the DMG attached here, or on GitHub releases, and who knows your boss might give you a raise…


![KeyPopper Diagram.pdf](https://github.com/LinusS1/KeyPopper/files/7080549/KeyPopper.Diagram.pdf)

