# xbar-homeassistant-plugin

## Description
This is my first attempt to a simple [xbar](https://xbarapp.com/) plugin for my [Home Assistant](https://www.home-assistant.io/) environment. I use it to show the status of the following:
* Wasching Machine
* Dishwasher
* Intruder Alarm

## Features
* It shows [icons](https://emojipedia.org/check-mark-button/) for the entities (if they are active) in the menu bar.
* It provides a list of all configured entities in the menu.
* The menu provides some information about the configured URLs and if they are reachable.
* If both configured URLs are reachable, the script would pull the information from the internal one.

## Usage
This plugin requires the following information:
* `HA_URL_INT`: Internal HomeAssistant URL (e.g. `http://192.168.0.10:8123`)
* `HA_URL_EXT`: External HomeAssistant URL (e.g. `https://my.smart.home`)
* `HA_TOKEN`: HomeAssistant [Long Lived Access Token](https://www.home-assistant.io/docs/authentication/#your-account-profile)
* `ENTITY_WASHING_MACHINE_STATUS`: Entity Name (e.g. `input_boolean.my_washing_machine`)
* `ENTITY_DISHWASHER_STATUS`: Entity Name (e.g. `input_boolean.my_dishwasher`)
* `ENTITY_ALARM_STATUS`: Entity Name (e.g. `input_boolean.my_alarm`)

## Disclaimer
Be prepared for bad spaghetti code, bad formatting, bad variable names, bad everything. I don't really mind it though, it works for me :)