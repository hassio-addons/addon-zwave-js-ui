# Home Assistant Community Add-on: Z-Wave JS to MQTT

The Z-Wave JS to MQTT add-on provides two primary capabilities in addition to
Home Assistant's official Z-Wave JS add-on:

1. A web-based UI control panel, allowing you to configure every aspect of your  
Z-Wave network.
1. Two ways for your Z-Wave controller to communicate with Home Assistant:
    - (Recommended) Directly (without MQTT) using the built-in Z-Wave JS Home  
    Assistant integration.
    - (Not Recommended) Through an MQTT Gateway (disabled by default) to your  
    MQTT broker.

Some advantages and use cases:

- Compatible with the Home Assistant Z-Wave JS integration.
- Your Z-Wave network will keep running between Home Assistant restarts.
- You can directly use things like Node-RED with your Z-Wave network, while it  
  is available for Home Assistant at the same time.
- Allow [ESPHome.io][esphome] based ESP devices to directly respond or work with  
  your Z-Wave network.
- Pre-configures itself with the Mosquitto add-on (when found).

This add-on uses the [Zwavejs2Mqtt][zwavejs2mqtt] software.

## Installation

The installation of this add-on is not different in comparison to installing any  
other Home Assistant add-on.

1. Click the Home Assistant My button below to open the add-on on your Home  
   Assistant instance.

   [![Open this add-on in your Home Assistant instance.][addon-badge]][addon]

**Note** - If this link does not work and/or you do not see Z-Wave JS to MQTT in  
the add-on store, click this:

<I don't konw how to insert markdown for the repo button, but frenck can add it  
from this discussion...https://github.com/hassio-addons/addon-zwavejs2mqtt/discussions/363>

1. Click the Install button to install the add-on.
1. Check the logs of the Z-Wave JS to MQTT add-on to see if everything went  
   well.
1. Click the OPEN WEB UI button.
1. Enjoy the add-on!

**NOTE**: The upstream project has documentation on using the software itself:
<https://zwave-js.github.io/zwavejs2mqtt/#/>

## Home Assistant Integration

By default, the Home Assistant Z-Wave JS integration will try to set up the  
official Z-Wave JS add-on from the official add-on store. **Home Assistant  
recommends the official Z-Wave JS add-on.** However, as explained above, the  
Z-Wave JS to MQTT community add-on will provide a Web UI and the ability to  
send/receive data over MQTT as well.

### Configure Z-Wave JS to MQTT

1. Open the Z-Wave JS to MQTT control panel by clicking the "OPEN WEB UI"  
   button on the Z-Wave JS to MQTT add-on page.
1. Open the Menu (three horizontal lines)
1. Click Settings
1. Click Z-Wave
1. Serial Port - Select or enter the appropriate port (e.g., `/dev/tty/USB0`)
1. Network Key(s) - Click the double-arrow icons next to each network key to  
   randomly generate a network key
1. Click SAVE" button
1. Navigate to the Control Panel. If you had devices paired already, you should  
   see them slowly populate.

### Configure Z-Wave JS Integration to work with Z-Wave JS to MQTT add-on directly

1. Navigate to Integrations.
1. Click "+ Add Integration".
1. Select the "Z-Wave JS" integration from the list.
1. Uncheck "Use the Z-Wave JS Supervisor add-on"
1. Click Submit
1. Copy and Paste "ws://a0d7b954-zwavejs2mqtt:3000"
1. Click Submit
1. Set your devices to the areas they are installed in, then click Finish
1. Confirm and done!

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
log_level: info
```

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can be  
changed to be more or less verbose, which might be useful when you are dealing  
with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a more  
severe level, e.g., `debug` also shows `info` messages. By default, the  
`log_level` is set to `info`, which is the recommended setting unless you are  
troubleshooting.

## Known issues and limitations

- Z-Wave JS to MQTT supports Home Assistant Discovery over MQTT. It is  
  **STRONGLY** recommended **NOT** to use that option. Use the Z-Wave JS  
  integration as documented above instead.

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases] functionality.

Releases are based on [Semantic Versioning][semver], and use the format of  
`MAJOR.MINOR.PATCH`. In a nutshell, the version will be incremented based on the  
following:

- `MAJOR`: Incompatible or major changes.
- `MINOR`: Backwards-compatible new features and enhancements.
- `PATCH`: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Community Add-ons Discord chat server][discord] for add-on  
  support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home  
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2021 - 2022 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=a0d7b954_zwavejs2mqtt
[contributors]: https://github.com/hassio-addons/addon-zwavejs2mqtt/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord]: https://discord.me/hassioaddons
[esphome]: https://esphome.io/components/mqtt.html#on-message-trigger
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/?u=frenck
[frenck]: https://github.com/frenck
[issue]: https://github.com/hassio-addons/addon-zwavejs2mqtt/issues
[reddit]: https://reddit.com/r/homeassistant
[releases]: https://github.com/hassio-addons/addon-zwavejs2mqtt/releases
[repository-badge]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg
[repository]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fhassio-addons%2Frepository
[semver]: http://semver.org/spec/v2.0.0.htm
[zwavejs2mqtt]: https://github.com/zwave-js/zwavejs2mqtt
