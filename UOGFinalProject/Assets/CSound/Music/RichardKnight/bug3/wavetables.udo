#ifndef UDO_WAVETABLES
#define UDO_WAVETABLES ##
/*
	Debugger - Unfixed Bugs : BUG #3

	General waveforms
*/

ipoints = 16384
gifnCosine ftgen 0, 0, ipoints, 9, 1, 1, 90
gifnSine ftgen 0, 0, ipoints, 10, 1
gifnSquare ftgen 0, 0, ipoints, 10, 1, 0, 0.3, 0, 0.2, 0, 0.14, 0, .111
gifnSaw ftgen 0, 0, ipoints, 10, 0, .2, 0, .4, 0, .6, 0, .8, 0, 1, 0, .8, 0, .6, 0, .4, 0, .2

#end

