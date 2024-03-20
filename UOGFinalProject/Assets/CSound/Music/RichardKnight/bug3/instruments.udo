#ifndef UDO_INSTRUMENTS
#define UDO_INSTRUMENTS ##
/*
	Debugger - Unfixed Bugs : BUG #3

	Sound generators
	Names should correspond to those used in BID file, prepended with play_
*/


#include "wavetables.udo"
#include "bussing.udo"
#include "bid.udo"
#include "oprepare.udo"
#include "effects.udo"


/*
	tb303 style synth
*/
instr play_303
	iamp = bid_getparameter(p4, p5, 2)
	ifilter = bid_getparameter(p4, p5, 4) * 100
	inote = tab_i(random(1, ftlen(gibid_chordfn) - 3), gibid_chordfn)

	ifrq1 = 440 * exp(log(2) * (ifilter - 69) / 12)	; filter start freq.
	kamp linseg 1, p3-0.15, 1, 0.025, 0, 1, 0	; release envelope
	kcps init cpsmidinn(inote)
	kffrq port 0, 60/150, ifrq1		; filter frequency
	a1 phasor kcps		; oscillator
	a1 = 1 - 2 * a1

	a1x butterbp a1, kffrq, kcps * 1.0			; filters
	a1x =  a1x * (2 + kffrq / kcps)	; correct amplitude
	a1 = a1x + a1 * 0.25 ; 0.5
	a1 butterlp a1, kffrq

	a1 = taninv(a1 * 4 * iamp)	; distortion ; 2.5

	keqf limit kffrq * 4, 10, sr * 0.48	; EQ frequency
	a1 pareq a1 * 0.4, keqf, 4.0, 1.0, 2
	a1 butterhp a1, 50
	a1 = a1 * kamp * 0.72
	aL, aR pan2 a1, random(0.3, 0.7)
	bus_mix("mdelay", aL*0.1, aR*0.1)
	bus_mix("master", aL, aR)
endin


/*
	Blocky square-ish sounding FM bass
*/
instr play_bass
	iamp = bid_getparameter(p4, p5, 2)
	ilower = bid_getparameter(p4, p5, 4)
	iaugment = (random(0, 1) < 0.1 || ilower == 1) ? 36 : 24
	inote = tab_i(random(1, ftlen(gibid_chordfn) - 3), gibid_chordfn) - iaugment
	a1 foscil 0.56, cpsmidinn(inote), 1, 2, random(0, 6), gifnSine
	a1 pareq a1, 150, 0.24, 0.9
	a1 pareq a1, 80, 1.3, 0.9
	kenv linseg 1, p3, 0
	aout = a1*kenv
	bus_mix("master", aout, aout)
endin


/*
	Auto-portamento sweepy synth
*/
instr play_mel1
	iamp = bid_getparameter(p4, p5, 2)
	ihigher = bid_getparameter(p4, p5, 4)
	iaugment1 = (ihigher == 1 && random(0, 1) > 0.6) ? 12 : 0
	ifreq1 = cpsmidinn(tab_i(random(1, ftlen(gibid_chordfn) - 1), gibid_chordfn) + iaugment1)
	ifreq2 = cpsmidinn(tab_i(random(1, ftlen(gibid_chordfn) - 1), gibid_chordfn))
	kfreq linseg ifreq1, p3*0.4, ifreq1, p3*0.2, ifreq2, p3*04, ifreq2
	kfreq += oscil(10, 6)
	kcar = abs(oscil(4, 0.001)) + 1
	a1 foscil 0.4, kfreq, kcar, 1, random(0, 6), gifnSine
	a1 butterhp a1, 600
	a1 *= abs(oscil(2, (gibid_tempo / 60) * int(random(1, 8)), gifnSine))
	kenv linseg 0, p3*0.2, random(0.8, iamp), p3*0.6, random(0.8, iamp), p3*0.2, 0
	aL, aR pan2 a1*kenv*0.7, random(0.2, 0.8)
	bus_mix("mdelay", aL*0.1, aR*0.1)
	bus_mix("reverb", aL*0.5, aR*0.5)
	bus_mix("master", aL, aR)
endin



/*
	Convenience opcode for playing current chord on given instrument, passing p4 as note and p5 as amp
	
	chordinstrument Sinstrument

	Sinstrument	the instrument name
	ipos		position in pattern
	idataindex	section specific data index; pointer to ftable
*/
opcode chordinstrument, 0, Sii
	Sinstrument, ipos, idataindex xin
	iamp = bid_getparameter(ipos, idataindex, 2)
	index = 1  ; index 0 is chordgroup length
	while (index < ftlen(gibid_chordfn)) do
		event_i "i", Sinstrument, 0, p3, tab_i(index, gibid_chordfn), iamp
		index += 1
	od
	
endop


/*
	Portamento swept lead synth pad, internal use
*/
instr chord1
	inote = p4
	iamp = p5
	kfreq1 linseg cpsmidinn(inote-36), p3*0.1, cpsmidinn(inote+12), p3*0.9, cpsmidinn(inote+12)
	kindex linseg 1, p3, 5
	aL1 foscil 0.1, kfreq1 + oscil:k(3, 10), 5, 1, kindex, gifnSquare
	aR1 foscil 0.1, kfreq1 + oscil:k(4, 6), 5, 1, kindex, gifnSquare
	aL1 butterlp aL1, abs(oscil(1000, 3)) + 500
	aR1 butterlp aR1, abs(oscil(1000, 5)) + 500
	
	kfreq2 linseg cpsmidinn(inote-12), p3*0.1, cpsmidinn(inote), p3*0.7, cpsmidinn(inote), p3*0.2, cpsmidinn(inote-36)
	aL2 foscil 0.1, kfreq2 + oscil:k(3, 7), 2, 5, 5-kindex, gifnSine
	aR2 foscil 0.1, kfreq2 + oscil:k(3, 5), 3, 3, 5-kindex, gifnSine
	kenv1 linseg 1, p3*0.8, 1, p3*0.2, 0
	kenv2 linseg 0, p3*0.3, 1, p3*0.69, 1, p3*0.01, 0
	aL butterhp (aL1*kenv1)+(aL2*kenv2), 500
	aR butterhp (aR1*kenv1)+(aR2*kenv2), 500
	
	bus_mix("reverb", aL*0.4, aR*0.4)
	aL *= 1-gkpump
	aR *= 1-gkpump
	bus_mix("master", aL, aR)
endin


/*
	Slightly ambienty type pad, internal use
*/
instr chord2 
	inote = p4
	iamp = p5 
	a1 fmbell 0.2*iamp, cpsmidinn(inote+12), 1, 3, 0.05, 10, gifnSine, gifnSquare, gifnSine, gifnSquare, gifnSine
	a1 butterhp a1, 700
	kenv linseg 0, p3*0.5, 1, p3*0.4, 1, p3*0.1, 0
	aL, aR ensembleChorus a1*9*kenv, .07, .003, .75, 1, 4, gifnSine  ; changed from 12 to 4 voices for web IDE
  aL pareq aL, 1000, 0.4, 0.6
  aR pareq aR, 1000, 0.4, 0.6
	bus_mix("reverb", aL*0.2, aR*0.2)
	aL *= 1-gkpump
	aR *= 1-gkpump
	bus_mix("master", aL, aR)
endin


/*
	Housey organ, internal use
*/
instr chord3
	inote = p4 - 12
	iamp = p5
	aL fmb3 0.25, cpsmidinn(inote), 1, 2, 0.1, 10, gifnSine, gifnSquare, gifnSine, gifnSquare, gifnSine
	aR fmb3 0.25, cpsmidinn(inote), 1, 1.4, 0.2, 10, gifnSine, gifnSaw, gifnSine, gifnSquare, gifnSine
	aL butterhp aL, 340
	aR butterhp aR, 340
	aL butterlp aL, 1000
	aR butterlp aR, 1000
	kenv linseg 1, p3*0.5, 1, p3*0.4, 1, p3*0.1, 0
	aL *= kenv
	aR *= kenv
	bus_mix("reverb", aL*0.8, aR*0.8)
	bus_mix("mdelay", aL*0.1, aR*0.1)
	bus_mix("master", aL, aR)
endin


/*
	Play chord1 above, called from BID
*/
instr play_chord1
	chordinstrument "chord1", p4, p5
	turnoff
endin

/*
	Play chord2 above, called from BID
*/
instr play_chord2
	chordinstrument "chord2", p4, p5
	turnoff
endin

/*
	Play chord3 above, called from BID
*/
instr play_chord3
	chordinstrument "chord3", p4, p5
	turnoff
endin


/*
	Rimshot, derived from instrument by Istvan Varga
*/
instr play_rim
	iamp = bid_getparameter(p4, p5, 2)
	icps = 490*exp(log(2.0)*(57.0-69.0)/12.0)
	acps expon icps, 0.0025, icps * 0.5
	acps = acps + icps
	iamp = 1
	a1a phasor acps, 0.0	
	a1b phasor acps, 0.5
	afmenv expon 1.0, 0.02, 0.5
	a1 = (a1a-a1b)*6.0*afmenv
	acps = acps*(1.0+a1)
	a0 oscil3 1.0, acps
	a1 unirand 2.0
	a1 tone a1-1.0, 2000
	a0 = a0 + a1*0.1
	aenv expon 1.0, 0.005, 0.5
	a0 limit 4.0*iamp*a0*aenv, -1.0, 1.0
	a0 table3 a0*4096.0, gifnSine, 0, 0, 1
	kffrq expseg 2000, 0.07, 100, 1, 100
	a0x tone a0, 10000
	a0y = a0 - a0x
	a0x delay a0y, 0.0002
	a0 = a0 - a0x*4.0
	a0 pareq a0, kffrq, 0, 0.7071, 2
	a_ linseg 1, p3-0.1, 1, 0.025, 0, 1, 0
	a0 = a0*a_
	aL, aR pan2 a0*iamp, random(0.3, 0.8)

	bus_mix("reverb", aL*0.3, aR*0.3)
	bus_mix("master", aL, aR)
endin


/*
	909 open hi-hat using oprepare sound
*/
instr play_hat909
	iamp = bid_getparameter(p4, p5, 2)
	ifn = oprepare_getfn("hat909")
	apos phasor (1/(ftlen(ifn)/sr))
	aout1 table3 apos*0.4, ifn, 1
	aout2 table3 apos*0.9, ifn, 1
	aout3 table3 apos*1.1, ifn, 1
	amix1 = delay(aout1*0.6, 0.02) + delay(aout2*0.8, 0.01)
	amix2 = delay(aout1*0.8, 0.01) + delay(aout2*0.6, 0.02)
	aL = (aout3 + amix1 + (amix2 * 0.3))*0.4*iamp
	aR = (aout3 + amix2 + (amix1 * 0.3))*0.4*iamp
	bus_mix("reverb", aL*0.1, aR*0.1)
	bus_mix("master", aL, aR)
endin


/*
	909 closed hi-hat using oprepare sound
*/
instr play_hat909c
	iamp = bid_getparameter(p4, p5, 2)
	ifn = oprepare_getfn("hat909")
	apos phasor (1/(ftlen(ifn)/sr))
	aL table3 apos*0.65, ifn, 1
	aR table3 apos*0.76, ifn, 1
	aL *= iamp * 0.6
	aR *= iamp * 0.6
	aL *= 1-gkpump
	aR *= 1-gkpump
	bus_mix("reverb", aL*0.1, aR*0.1)
	bus_mix("master", aL, aR)
endin


/*
	Pseudo-crash using 909 hi-hat oprepare sound
*/
instr play_crash
	iamp = 1
	ifn = oprepare_getfn("hat909")
	apos phasor (1/(ftlen(ifn)/sr))
	ax table3 apos, ifn, 1
	aL reverb ax, 8
	aR reverb ax, 8
	kfreq line 1400, p3, 100
	aL *= oscil(0.9, kfreq) * iamp * 0.2 
	aR *= oscil(0.9, kfreq) * iamp * 0.2
	aLx vdelay ax*0.3, abs(oscil(0.2, 2)), 1
	aRx vdelay ax*0.3, abs(oscil(0.3, 3)), 1
	aL += aLx
	aR += aRx
	aL *= 0.5
	aR *= 0.5
	bus_mix("reverb", aL*0.9, aR*0.9)
	bus_mix("mdelay", aL*0.5, aR*0.5)
	bus_mix("master", aL, aR)
endin


/*
	Clap
*/
instr play_clap909
	iamp = bid_getparameter(p4, p5, 2)
	ilowpass = bid_getparameter(p4, p5, 4)
	p3 = 0.065
	aL noise 1, 0.9
	aR noise 0.5, 0.4
	aL butterbp aL, 1200, 1100
	aR butterbp aR, 1200, 1100
	aL butterhp aL, 400
	aR butterhp aR, 400
	irevsend = 0.2
	if (ilowpass == 1) then
		aL butterlp aL, 900
		aR butterlp aR, 900
		irevsend = 0.6
	endif
	kamp1 linseg 1, p3*0.1, 0, p3*0.1, 1, p3*0.2, 0.1, p3*0.3, 0.5, p3*0.2, 0, p3*0.05, 0.4, p3*0.05, 0
	kamp2 linseg 1, p3*0.15, 0, p3*0.15, 1, p3*0.1, 0.1, p3*0.2, 0.5, p3*0.3, 0, p3*0.05, 0.4, p3*0.05, 0

	aL = aL*kamp1*7*iamp
	aR = aR*kamp2*7*iamp

	bus_mix("reverb", aL*irevsend, aR*irevsend)
	bus_mix("master", aL, aR)
endin


/*
	808 style kick
*/
instr play_kick	
	iamp = bid_getparameter(p4, p5, 2)
	xtratim 0.1
	krelease release
	ktune init 0
	kmul transeg 0.2, p3*0.5, -15, 0.01, p3*0.5, 0, 0
	kbend transeg 0.5, 1.2, -4, 0, 1, 0, 0
	asig gbuzz 0.5, 50*octave(ktune)*semitone(kbend), 20, 1, kmul, gifnCosine
	aenv transeg 1, p3-0.004, -6, 0
	gkpump = k(aenv)
	aatt linseg 0, 0.004, 1
	asig = asig*aenv*aatt
	aenv linseg 1, 0.07, 0
	acps expsega 400, 0.07, 0.001, 1, 0.001
	aimp oscili aenv, acps*octave(ktune*0.25)
	amix = ((asig*0.7)+(aimp*0.35))*2*iamp
	gkpump = min(rms(amix) * 7, 1)
	amix distort amix, 0.4, gifnSine
	;amix butterhp amix, 150
	bus_mix("master", amix, amix)
endin


#end
