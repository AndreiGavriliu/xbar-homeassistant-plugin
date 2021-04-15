#!/bin/bash

# <xbar.title>HomeAssistant plugin for xbar</xbar.title>
# <xbar.version>v0.1</xbar.version>
# <xbar.author>Andrei Gavriliu</xbar.author>
# <xbar.author.github>andrei.gavriliu</xbar.author.github>
# <xbar.desc>Small App to show some important information (to me, at least)</xbar.desc>
# <xbar.image>https://brands.home-assistant.io/_/panel_custom/logo.png</xbar.image>
# <xbar.dependencies>bash,jq</xbar.dependencies>
# <xbar.abouturl>https://github.com/AndreiGavriliu/xbar-homeassistant-plugin</xbar.abouturl>

# PREFERENCES
# <xbar.var>string(HA_URL_INT=""): HomeAssistant internal URL</xbar.var>
# <xbar.var>string(HA_URL_EXT=""): HomeAssistant external URL</xbar.var>
# <xbar.var>string(HA_TOKEN=""): HomeAssistant Long-Lived Token</xbar.var>
# <xbar.var>string(OVERRIDE_HA_NAME=""): Override HomeAssistant instance name. If left empty, we will use the value of .installation_type</xbar.var>
# <xbar.var>boolean(SHOW_HA_NAME=true): Show HomeAssistant instance name in menu bar</xbar.var>

# ENTITIES
# <xbar.var>string(ENTITY_WASHING_MACHINE_STATUS=""): Washing machine status entity</xbar.var>
# <xbar.var>string(ENTITY_DISHWASHER_STATUS=""): Dishwasher status entity</xbar.var>
# <xbar.var>string(ENTITY_ALARM_STATUS=""): Dishwasher status entity</xbar.var>

# collection of icons
HA_ICON="iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAIAAABL1vtsAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH5QQPBQYShJaCIgAAA1JJREFUOMulVEtonFUU/s69/2v+mc5MHjaJlqSjaWKnxQeoRXcuxOpCMS6KuFCpVHHlQsRHlhZ3XetWVy0IhW5ELCIVoQg1JaEPrKRJmjYzE5t5/fO/7r3HxUzSadOI6IW7OYfzne9+95yPnj8b4P8d6x9y1LsAg/8DBAEGSJQB4EghsCOK2KmegXaczpad2bITxClvEvpXLLr1rSidPei+9JADINXmi4U459mCelnDO0N0W7Wi9NMDzqvjnjIA8Mq4pxlfXopd2+4oYwnKWnR/iG64HqUf73dmJjKGIQgADOO1Ca+jzOmV5N1ydr6uTt9QriX5Hi226j8pu0dKmUasT5xfXg+TWic5cX65k+o3H/GPP+m/+KD9wojUKr1Xzu7/bYTpZwe8Q4P4+uKaKynvOWeXmj8uNYdz3sVqcOpybarQlUaz1kR3QwCoh+mH0/brE249NrdDbZiPPTHqWMKW4u2DuwPFK+1e56wllGHDPeKy9NbnBNSj9INJ+519PgAhEGn+vdKerwWPPZCVgk5dWWei8YL3zUJlJGuXhzKS+Jea8iwJQEhCK9HvTTpHp/yu/nlHAvijoZ4ZyyfaWISZ6eGllvphuf3cnsLeggfg6HTu/UmnlWhJsAzDJZ6rtD9arR57fPfUYObklfXFlq6nvBqkIxm5GqmbQfrsWPZWR71cKgK4thF+NVftWL5LrmFYDNhSXGjQRl29UTYADpcGEsN7cs7PK83vrzcOjeXmamGo8PSo39WikZgzq2qgSL4nuCenELmsP1zMCyEAXG9E3y5Um7FONAcKBc+qRXx1I662k+O/LrVilbGtwcKuXNaHEHdGiwG9ObOlgjdRiH+60bx6O35qNPvdtcbhvflHB9xKkJQGfEcKw8r07e7mdDIAZgYA35Z5xzq3FjqChjy5f8B7OG9dqLQrQTKzb8i1RKyZ6M7m3jXgUvQsohqmR6aKzdj8Vg1dgUt/hb4ttjpL6lvHfggp5JnF5vxaUzF8x/pzI7IknbsVMfOQZ+lQ2VKevLxuERZDSCG3WNCW8bFWzXaQRCEIgGAAJIq5DBj1IGTWBCI2ABwvk89lSVrbHiJksZCnwq5+ezIgAKOZTP86M+j+fkFEDDBouz2ZbSHqC/wNY9OEH3hrvj4AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjEtMDQtMTVUMDU6MDY6MTgtMDQ6MDC5bOBiAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIxLTA0LTE1VDA1OjA2OjE4LTA0OjAwyDFY3gAAAABJRU5ErkJggg=="

# checking internal URL 
####################################################################################################
JSON_RESPONSE=$(curl --silent --max-time 1 -X GET -H "Content-Type: application/json" "${HA_URL_INT}/api/discovery_info")
HA_INSTALLATION_TYPE=$(/usr/local/bin/jq -r '.installation_type' <<< "${JSON_RESPONSE}")
if [ "${HA_INSTALLATION_TYPE}" == "Home Assistant OS" ]; then
    HA_URL_INT_CHECK="true"
else
    HA_URL_INT_CHECK="false"
fi

# checking external URL
####################################################################################################
JSON_RESPONSE=$(curl --silent --max-time 1 -X GET -H "Content-Type: application/json" "${HA_URL_EXT}/api/discovery_info")
HA_INSTALLATION_TYPE=$(/usr/local/bin/jq -r '.installation_type' <<< "${JSON_RESPONSE}")
if [ "${HA_INSTALLATION_TYPE}" == "Home Assistant OS" ]; then
    HA_URL_EXT_CHECK="true"
else
    HA_URL_EXT_CHECK="false"
fi

# set active URL
####################################################################################################
if [ "$HA_URL_INT_CHECK" = "true" ] && [ "$HA_URL_EXT_CHECK" = "true" ]; then HA_URL="${HA_URL_INT}"; fi
if [ "$HA_URL_INT_CHECK" = "false" ] && [ "$HA_URL_EXT_CHECK" = "true" ]; then HA_URL="${HA_URL_EXT}"; fi

# translate response to icons
####################################################################################################
if [ "$HA_URL_INT_CHECK" = "true" ]; then HA_URL_INT_CHECK="✔️"; else HA_URL_INT_CHECK="✖️"; fi
if [ "$HA_URL_EXT_CHECK" = "true" ]; then HA_URL_EXT_CHECK="✔️"; else HA_URL_EXT_CHECK="✖️"; fi

# build title
####################################################################################################
if [ "$SHOW_HA_NAME" == "true" ]; then
    # show HA name in menu bar next to icon
    if [ "$OVERRIDE_HA_NAME" == "" ]; then
        # no override name found in config, using location name
        HA_NAME="$(/usr/local/bin/jq -r '.location_name' <<< "${JSON_RESPONSE}")| image=${HA_ICON}"
    else
        HA_NAME="$OVERRIDE_HA_NAME| image=${HA_ICON}"
    fi
else
    # do not show any name next to the icon
    HA_NAME="| image=${HA_ICON}"
fi

# get entity details
####################################################################################################
_get_entity_state() {
    JSON_RESPONSE=$(curl --silent --max-time 1 -X GET -H "Authorization: Bearer ${HA_TOKEN}" -H "Content-Type: application/json" "${HA_URL}/api/states/${1}")
    /usr/local/bin/jq -r '.state' <<< "${JSON_RESPONSE}"
}
_get_entity_name() {
    JSON_RESPONSE=$(curl --silent --max-time 1 -X GET -H "Authorization: Bearer ${HA_TOKEN}" -H "Content-Type: application/json" "${HA_URL}/api/states/${1}")
    /usr/local/bin/jq -r '.attributes.friendly_name' <<< "${JSON_RESPONSE}"
}

# set font color based on darkmode status
####################################################################################################
if [ "$XBARDarkMode" == "true" ]; then
    FONT_COLOR="| color=white"
else
    FONT_COLOR="| color=black"
fi

# get washing machine status, set name and icon
####################################################################################################
if [ "$ENTITY_WASHING_MACHINE_STATUS" != "" ]; then
    ENTITY_STATE=$(_get_entity_state "$ENTITY_WASHING_MACHINE_STATUS")
    ENTITY_NAME=$(_get_entity_name "$ENTITY_WASHING_MACHINE_STATUS")
    if [ "$ENTITY_STATE" == "off" ]; then
        STATE_WASHING_MACHINE_STATUS="off"
        RESPONSE_WASHING_MACHINE_STATUS="🔴"
    else
        STATE_WASHING_MACHINE_STATUS="on"
        RESPONSE_WASHING_MACHINE_STATUS="🟢"
    fi
    RESPONSE_WASHING_MACHINE_NAME="${ENTITY_NAME} ${FONT_COLOR}"
fi

# get dishwasher status, set name and icon
####################################################################################################
if [ "$ENTITY_DISHWASHER_STATUS" != "" ]; then
    ENTITY_STATE=$(_get_entity_state "$ENTITY_DISHWASHER_STATUS")
    ENTITY_NAME=$(_get_entity_name "$ENTITY_DISHWASHER_STATUS")
    if [ "$ENTITY_STATE" == "off" ]; then
        STATE_DISHWASHER_STATUS="off"
        RESPONSE_DISHWASHER_STATUS="🔴"
    else
        STATE_DISHWASHER_STATUS="on"
        RESPONSE_DISHWASHER_STATUS="🟢"
    fi
    RESPONSE_DISHWASHER_NAME="${ENTITY_NAME} ${FONT_COLOR}"
fi

# get alarm status, set name and icon
####################################################################################################
if [ "$ENTITY_ALARM_STATUS" != "" ]; then
    ENTITY_STATE=$(_get_entity_state "$ENTITY_ALARM_STATUS")
    ENTITY_NAME=$(_get_entity_name "$ENTITY_ALARM_STATUS")
    if [ "$ENTITY_STATE" == "off" ]; then
        STATE_ALARM_STATUS="off"
        RESPONSE_ALARM_STATUS="🔴"
    else
        STATE_ALARM_STATUS="on"
        RESPONSE_ALARM_STATUS="🟢"
    fi
    RESPONSE_ALARM_NAME="${ENTITY_NAME} ${FONT_COLOR}"
fi

# build output
####################################################################################################
if [ "$STATE_WASHING_MACHINE_STATUS" == "on" ]; then echo -n "👕"; fi
if [ "$STATE_DISHWASHER_STATUS" == "on" ]; then echo -n "🍸"; fi
if [ "$STATE_ALARM_STATUS" == "on" ]; then echo -n "🔒"; fi
echo "$HA_NAME"
echo ---
if [ "$HA_URL_INT" == "" ] &&  [ "$HA_URL_EXT" == "" ]; then
    echo "Please configure URLs first"
else
    echo "$RESPONSE_WASHING_MACHINE_STATUS $RESPONSE_WASHING_MACHINE_NAME"
    echo "$RESPONSE_DISHWASHER_STATUS $RESPONSE_DISHWASHER_NAME"
    echo "$RESPONSE_ALARM_STATUS $RESPONSE_ALARM_NAME"
    echo "Status"
    if [ "$HA_URL_INT" != "" ]; then echo "-- ${HA_URL_INT_CHECK} ${HA_URL_INT} | href=${HA_URL_INT}"; fi
    if [ "$HA_URL_EXT" != "" ]; then echo "-- ${HA_URL_EXT_CHECK} ${HA_URL_EXT} | href=${HA_URL_EXT}"; fi
fi