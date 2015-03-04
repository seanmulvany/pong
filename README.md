# pong clone
one player version

This is a one player game and is based on a vimeo tutorial for a simple 2 player pong clone by Steve Quinlan. He has an excellent segment at http://vimeo.com/93028331. 

There are three controller versions included here. Main.rb is controlled with the Up/Down keys. Main_mouse.rb can be controlled with a mouse or touchpad. Finally, there is a gesture-controlled version that uses the LeapMotion controller. To use this version, first open test.rb or leap_motion_driver.rb (but not both) when you have connected your LeapMotion. Test.rb and leap_motion_driver.rb are drivers built on the artoo gem that takes x coordinate values from the LeapMotion. Test.rb takes these from the position of your index finger and leap_motion_driver.rb uses your palm x coordinates. Then open main_leapmotion.rb to play pong.

