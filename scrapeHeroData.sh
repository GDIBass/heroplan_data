#!/bin/bash

##### PRE REQUISITES
## Install shot-scraper and playwright
## Run these commands in order

# pip install shot-scraper
# playwright install

HERO=$1

if [ -z "$HERO" ]; then
    echo "🚨 HERO is not specifed."
    echo "Usage: scrapeHeroData.sh Grace" 
    exit 1
fi

URL=https://empiresandpuzzles.fandom.com/wiki/$HERO

shot-scraper javascript $URL "({
  name: document.querySelector('h2[data-source=title1]').innerText,
  class: document.querySelector('div[data-source=class] a:nth-of-type(2)').innerText,
  source: '<TODO>',
  speed: document.querySelector('div[data-source=mana_speed] div.pi-data-value').innerText,
  power: Number(document.querySelector('td[data-source=power]').innerText),
  attack: Number(document.querySelector('td[data-source=attack]').innerText),
  defense: Number(document.querySelector('td[data-source=defense]').innerText),
  health: Number(document.querySelector('td[data-source=health]').innerText),
  skill: document.querySelector('div[data-source=special_name] div.pi-data-value').innerText,
  effects: Array.from(document.querySelectorAll('div[data-source^=effect] div')).map((n) => n.innerText.split('\n')[0]),
  types: ['<TODO>'],
  passives: document
    .querySelector('div[data-source=resist] div')
    .innerText.split('\n')
    .filter((n) => n.trim() && n !== '\n')
    .map((n) => n.trim()),
  image: '<TODO>',
  family: document.querySelector('div[data-source=family] a:nth-of-type(2)').innerText,
})" | yq -P '.' > $HERO.yaml
