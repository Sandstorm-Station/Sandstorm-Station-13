## TemptStation
Based and maintained from SPLURT Station, which is (not) based and maintained from Sandstorm Station 13, which is based and maintained from Citadel, which is based and mantained from /tg/station.

[![CI Suite](https://github.com/TemptStation/TemptStation/workflows/CI%20Suite/badge.svg)](https://github.com/TemptStation/TemptStation//actions?query=workflow%3A%22CI+Suite%22)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/TemptStation/TemptStation.svg)](http://isitmaintained.com/project/TemptStation/TemptStation "Percentage of issues still open")
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/TemptStation/TemptStation.svg)](http://isitmaintained.com/project/TemptStation/TemptStation "Average time to resolve an issue")

[![forthebadge](http://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/pretty-risque.svg)](https://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/you-didnt-ask-for-this.svg)](http://forthebadge.com) [![forinfinityandbyond](https://user-images.githubusercontent.com/5211576/29499758-4efff304-85e6-11e7-8267-62919c3688a9.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

**/tg/station Information**
* **Website:** <https://www.tgstation13.org>
* **Code:** <https://github.com/tgstation/tgstation>
* **Wiki:** <https://tgstation13.org/wiki/Main_Page>
* **Codedocs:** <https://codedocs.tgstation13.org>
* **/tg/station Discord:** <https://tgstation13.org/phpBB/viewforum.php?f=60>
* **Coderbus Discord:** <https://discord.gg/Vh8TJp9>

**Citadel Station (upstream) Information**
* **Website:** <http://citadel-station.net>
* **Code:** <https://github.com/Citadel-Station-13/Citadel-Station-13>

**Sandstorm Station (upstream) Information**
* **Code:** <https://github.com/SandPoot/Sandstorm-Station-13>

**S.P.L.U.R.T. Station Information**
* **Code:** https://github.com/SPLURT-Station/S.P.L.U.R.T-Station-13

**TemptStation Information**
* **Code:** https://github.com/TemptStation/TemptStation13
* **Discord:** https://discord.gg/PF4eKGWpam

## DOWNLOADING
[Downloading](.github/guides/DOWNLOADING.md)

[Running on the server](.github/guides/RUNNING_A_SERVER.md)

[Maps and Away Missions](.github/guides/MAPS_AND_AWAY_MISSIONS.md)

## :exclamation: How to compile :exclamation:

On **2021-01-04** we have changed the way to compile the codebase.

**The quick way**. Find `bin/server.cmd` in this folder and double click it to automatically build and host the server on port 1337.

**The long way**. Find `bin/build.cmd` in this folder, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile. If it closes, it means it has finished its job. You can then [setup the server](.github/guides/RUNNING_A_SERVER.md) normally by opening `tgstation.dmb` in DreamDaemon.

**Building tgstation in DreamMaker directly is now deprecated and might produce errors**, such as `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**

## Contributors
[Guides for Contributors](.github/CONTRIBUTING.md)

[/tg/station HACKMD account](https://hackmd.io/@tgstation) - Design documentation here

[Interested in some starting lore?](https://github.com/tgstation/common_core)


## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](http://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and GPLv3.txt for more details.

The TGS3 API is licensed as a subproject under the MIT license.

See the footers of code/\_\_DEFINES/server\_tools.dm, code/modules/server\_tools/st\_commands.dm, and code/modules/server\_tools/st\_inteface.dm for the MIT license.

tgui clientside is licensed as a subproject under the MIT license.
Font Awesome font files, used by tgui, are licensed under the SIL Open Font License v1.1
tgui assets are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
