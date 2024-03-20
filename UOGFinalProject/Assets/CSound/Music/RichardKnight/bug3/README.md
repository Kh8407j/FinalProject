# Debugger - Unfixed Bugs Volume 1

## Overview
Unfixed Bugs is a series of pieces of music by the artist Debugger, which may take the form of a traditional album, but solely feature compositions created using textual programming languages. The pieces are presented as open-source code and do not use any binary supporting files (such as PCM samples, analysis data etc). Hence Unfixed Bugs projects are fully readable, open-source musical works which describe both sound and arrangement. The compiled audio may be made available for release elsewhere. 

Aesthetically the project aims to represent the general approach to experimental techno music consistent with other output by Debugger, and exploit generative possibilities provided by defining musical structure with code.



## Composition Notes

### BUG3 (2021)
Significant work has been done on contructing a custom arrangment format for interpretation: the Bug Infested Directives (BID) format. This allows for reusable loop-based sequencing beyond the regular capabilities of the Csound score format. Also notably, a sample of a 909 hi-hat has been converted to a Csound instrument using FFT analysis, resulting in a large number of enveloped oscillators. This hi-hat instrument is too computationally heavy to be consistently run in realtime, so is recorded to memory before playback begins. The arrangement is computed during realtime playback.

The original BID file is provided as text (bid\_source.txt), but not all platforms support the readfi opcode as required by bid\_loadfile, hence it has been encapsulated in a string within bid_source.udo , and bid\_loadtext is used instead. If readfi is supported and bid\_loadfile is to be used, NOFILEIO should be unset.	


## Credits
All design, composition and programming by Richard Knight as Debugger. Mail to: q@1bpm.net



## License
Licensed under the Unlicense, so you can do as you please with the code. See the UNLICENSE file for more details.



## Links
* [git repository for Unfixed Bugs Volume 1](http://git.1bpm.net/csd-unfixedbugs1/about/)
* [Other Debugger releases on the Discogs page](https://www.discogs.com/artist/7224268-Debugger-3)
* [Richard Knight artist profile](http://rk.1bpm.net)
* [1bpm.net main page](http://1bpm.net/)
* [Csound page at 1bpm.net with plugin opcodes, builds etc](http://csound.1bpm.net/)
* [Official Csound site](https://csound.com/)

