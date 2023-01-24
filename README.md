# heroplan_data

This repository manages the data for Heroplan.

It is not currently fully operational!  Hero data will be loaded, but some data still has to be updated manually.

Things that must be manually updated:

* Families and Family Bonuses
* Hero Sources
* Troops
* New Costume Bonus types

When updating data please update them anyway, because they will be used in the future.

## What do I need to know to contribute

You'll need to know the following things in order to contribute:

1. How to use github & open a PR
2. How to use GNU image manipulator (or have the image file handy)
3. YAML and what it looks like and how it works


## 1. File locations

### a. Image templates

All templates are in GNU Image Manipulator (GIMP) format. You can use these templates to generate new heroes/troops.

* Hero image templates can be found in gimp/heroes/{color}.xcf
* Troops and small troops (the half height ones) are in gimp/troops.xcf and troops_small.xcf

Feel free to share these to whoever wants to be able to generate images.

### b. Hero information

Hero information is separted by color.  Heroes for each color can be found in:

``data/heroes/{color}/``

From there the files are separated out by stars (1star, 2star, 3star, etc).

## 2. Adding/updating heroes

### Adding hero data manually

1. Create a hero image (if it doesn't exist or needs updating)
* Open the template of the correct color
* Paste in a screenshot of the hero into the editor and center it around their face, resizing if needed 
* Make the correct star layer/wrapper visible
* Select the background of your image using the select tool
* Colorize the background to the appropriate color
* Export the image to the img/heroes directory as <heroname>.jpg or <heroname>costume.jpg
2. Upload the image to imgur
3. Copy the imgur link
4. Add a hero to the appropriate file with the following keys:
   (Do not use special characters, convert them to the English equivalent)

```
name:
 * required string
 * The name of the hero
class: required, one of Barbarian|Clerif|Druid|Fighter|Monk|Paladin|Ranger|Rogue|Sorcerer|Wizard
source:
 * required, one of season1|season2|season3|hotm|fables|teltoc|avalon|wonderland|pirates|springvale|sand|morlovia|christmas|secret|ninja|villains
 * The Hero source
speed:
 * required, one of very fast|fast|average|slow|very slow|charge
 * The hero speed
power:
 * required, integer
 * The maxed hero power stat
attack:
 * required, integer
 * The maxed hero attack stat
defense:
 * required, integer
 * The maxed hero defense stat
health:
 * required, integer
 * THe maxed hero health stat
skill:
 * required, string
 * The name of the heroe's special skill
effects:
 * required, array<string>
 * An array of strings that represents the heroes special skill
types:
 * required, array<string>
 * An array of strings that is an abbrevited representation of the skill
family:
 * optional, one of avalon|corellia|grimforest|teltoc|wonderland|springvale|sand|morlovia|christmas|ninja|lagoon|sakura|atlantis|alfheim|asgard|helheim|jotunheim|midgard|muspelheim|niflheim|svartalfhein|vanaheim|villains
 * The heroe's family
passives:
 * optional, array<string>
 * An array of strings that represent the heroe's passive abailities
image:
 * required, string
 * The imgur image location link
costume:
 * optional, map<type, typeValue>
 * A special key that takes a map of values.  This map takes the following keys, using the same validation as above
   * class
   * power
   * attack
   * defense
   * health
   * skill
   * effects
   * types
   * bonuses: (optional, and supports 2/2/4/1 or 3/3/6/1)
```

If you're adding a new family, source, speed or other appropriate config change please update those accordingly.  Eventually these will be updated dynamically.

### Adding hero data semi automatically

We now have a script to do some heavy lifting for you. 

#### Automated parts
  0. Download and setup prerequisites:
  ```
  pip install shot-scraper
  playwright install
  ```

  1. Clone the repo
  2. On a command line (use [wsl](https://learn.microsoft.com/en-us/windows/wsl/install) if on Windows), run
 ```
 ./utils/scrapeHeroData <name of hero>
 ```

 For example:

 ```
 ./utils/scrapeHeroData "Grace"
 ```
This will produce the follwoing `herodata.yml` file in you `./tmp` folder:

```
name: Grace
class: Druid
source: <TODO>
speed: Fast
power: 806
attack: 756
defense: 766
health: 1444
skill: Malison of the Wildlands
effects:
  - Deals 285% damage to the target and nearby enemies.
  - The target and nearby enemies cannot cast any new Taunt status effects for 3 turns.
  - The target and nearby enemies get -34% defense against Special Skills for 3 turns.
  - Element Link gives all Nature allies immunity to new Fiends for 4 turns
  - Element Link affects all allies when using 2 or more members of the same family.
types:
  - <TODO>
passives:
  - Resist Burn - This character has innate resistance against Burn.
  - Mana on Taunt - Each time an enemy receives a Taunt status effect this character’s mana is increased by 10% .
image: <TODO>
family: Legends 2022
```
  3. Follow steps 1-3 of [Adding hero data manually](#adding-hero-data-manually) to add the images. (this part may get automated in future)
  4. Complete any remaining `<todo>` parts
  5. Send a pull request with the new files.

If enough people contribute I'll set up a regular job to update heroes every night.
