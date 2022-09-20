# OOP-interactive-game-Frog-Frenzy-

Description:
We built a lab called frog frenzy which imitates a frog game where the frog is controlled
by an up and down button and the player has to avoid obstacles. This lab also contained a score
displayed which shows how many leaves(obstacles) the player has successfully doged. This lab
was a comprised of modules that were created in the previous labs.

Design: 
This module in the lab was my main draw module and it was in charge of
displaying all the items onto the VGA monitor. This module controlled the RGB for each
pixel. I had three outputs Red, Green, and Blue which then connected to the VGA red,
blue, and green in the top level. I had one wire for each active region like the, water,
plant, and frog and I defined each active region using my horizontal and vertical counters.
The horizontal and vertical counters were the pixel address in this case.
To make the water region I defined the active region as the lower half of the
screen, 240 onwards. To create the gradient of the water I calculated the difference from
the middle point and then used the lower four bits to calculate the shade of the blue.
The plant part was easier to implement. I started by just hardcoding the region and
getting a static green rectangle to appear on the monitor. Later while implementing the
frog movement I applied the same logic to move the plants. I made three different 10-bit
counters for each plant that load in different counter values depending on whether the
plant reached the respawn area or the game reset.
This part of the project was the hardest to implement just because it took me a
while to understand how the frames were being drawn. I first moved the frog at one pixel
per frame and later used a pulse extender to change the speed to three pixels per frame.
This helped me understand and visually see where each pixel was traveling.
Understanding that the bounds of the frog’s active region were constantly changing was
what helped me understand the crucks of this lab. My frog moves using an offset counter
that is synchronized with the states from my frog state machine. In every frame the offset
keeps getting bigger and the frog moves further away from the center. Once the offset hits
96 pixels it starts counting down and the frog begins traveling back to the center until the
offset is 0 pixels.

Testing and simulation:
In this lab, we were given a test bench to test if our Hsync and our Vsync were working
properly and if the RGB coloring was being done in the specified given active region. I used this
test bench and made a few modifications. Since this test bench was simulating only one row and
we needed 479 rows to complete and frame I synced my frame signal to go high whenever the
Hsync went high. This meant that in one row I would have 639 frames and I could watch how
each of my modules was working in accordance with the frames. I used this method to check my
offsets for all the objects like the frogs, water, and, plant.
Once I got my static objects to move on the screen I programmed my LEDs to match the
states from both my state machines. I used my LEDs[4:0] to match the frog states and my
LEDs[15:12] to match the game states. That way when I was playtesting my game I could see
exactly how the states were transitioning and which states they were getting stuck in.
Towards the end of the lab, I also coded my 7-segment display to display the output from
my counters to check if the transitions were happening exactly at 32 frames or not.
