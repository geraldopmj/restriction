**WHAT IS IT?**

This NetLogo model simulates a simple environment with agents (turtles) and patches that represent the income of the agent (lighter is more income). The agents represent individuals who move around the environment,having the income based on the actual patch. They will be classified into different socioeconomic classes based on the resources it have compared to the median of resources of all turtles. The model tracks the distribution of resources among the agents and displays the movement of agents in the environment.

**HOW IT WORKS**

-   The model initializes the environment with three types of resource patches, each represented by a different color (the lighter the bigger the income).
-   You can define the size of each patch type to simulate restriction since it will diminish or increase the chance of the agent to have the income of that patch.
-   Agents move randomly within the environment and gather resources from their current patch.
-   The classification of upper, middle, and lower classes is calculated based on median of resources turtles have.

The model is divided into three main parts: setup, go, and various sub-functions.

1.  **Setup**:
    
    -   The `setup` function initializes the simulation. It clears the environment, creates resource patches of different colors (representing different types of resources), and spawns a population of agents (turtles).
    -   The environment is divided into three regions with different colors: red (7), orange (8), and yellow (9).
    -   Agents (turtles) are initialized with a resource variable and placed in the environment.

2.  **Go**:
    
    -   The `go` function advances the simulation by performing several actions in each tick.
    -   Agents move randomly within the environment and consume and gather resources from their current patch based on their class.
    -   The model keeps track of patches without resources and restores patches to their original color if their resources are depleted for a certain period.
    -   The `countClass` function categorizes agents into upper, middle, or lower classes based on their resource levels.

3. **Sliders/switch:**

    -   Sliders and switch control consumption and resource availability.

**HOW TO USE IT**

1.  Open the NetLogo application.
2.  Open this model in NetLogo.
3.  Set the desired environment parameters, such as the size of the environment using NetLogo sliders.
4.  Click the "Setup" button to initialize the simulation.
5.  Check if the patch ratio is the desired.
6.  Click the "Go" button to start the simulation.
7.  Move the sliders and observe how the equality changes over time (more middle class, more equality).

**THINGS TO TRY**

You can experiment with the model by adjusting various parameters using NetLogo sliders, such as the size of the environment and the rate of resource consumption or resourcee scarcity.

**CREDITS AND REFERENCES**

 - https://investnews.com.br/economia/mais-pobres-migraram-para-classe-media-com-retomada-de-empregos-diz-estudo/
