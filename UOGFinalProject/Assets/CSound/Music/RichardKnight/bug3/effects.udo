#ifndef UDO_EFFECTS
#define UDO_EFFECTS ##
/*
	Debugger - Unfixed Bugs : BUG #3

	Audio effects
*/


/*
	A stereo chorus opcode with multiple voices
	By Bhob Rainey

	al, ar ensembleChorus ain, kdelay, kdpth, kminrate, kmaxrate, inumvoice, iwave

	al, ar		audio output
	
	ain 		audio input
	kdelay		delay time in seconds
	kdepth		chorus depth in seconds
	kminrate	min lfo rate cps
	kmaxrate	max lfo rate cps
	inumvoice	number of voices
	iwave		function table for the lfo wave (sine, triangle, etc).
	
*/
opcode ensembleChorus, aa, akkkkiip
	ain, kdelay, kdpth, kmin, kmax, inumvoice, iwave, icount xin
	incr = 1/(inumvoice)

	if (icount == inumvoice) goto out
		ainl, ainr ensembleChorus ain, kdelay, kdpth, kmin, kmax, inumvoice, iwave, icount + 1

out:

max:
	imax = i(kmax)
	if (kmax != imax) then 
		reinit max
	endif

	iratemax unirand imax
	rireturn
	alfo oscil kdpth, iratemax + kmin, iwave
	adel vdelay3 ain/(inumvoice * .5), (kdelay + alfo) * 1000, 1000
	al = ainl + adel * incr * icount
	ar = ainr + adel * (1 - incr * icount)
	xout al, ar
endop



#end
