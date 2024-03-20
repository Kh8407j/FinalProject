#ifndef UDO_INSTRUMENTS
#define UDO_INSTRUMENTS ##
/*
	Debugger - Unfixed Bugs : BUG #4

	Sound generators
	Names should correspond to those used in BID file, prepended with play_
*/


#include "wavetables.udo"
#include "bussing.udo"
#include "bid.udo"


/*
	303 bendy bass
*/
instr play_303
	iamp = bid_getparameter(p4, p5, 2)
	idirection = bid_getparameter(p4, p5, 4)

	if (idirection < 2) then
		inote1b  = tab_i(1, gibid_chordfn) - 24
		inote2b = tab_i(2, gibid_chordfn) - 36
		ifilter = (idirection == 0) ? 35 : 45
		inote1 = (idirection == 0) ? inote1b : inote2b
		inote2 = (idirection == 0) ? inote2b : inote1b
	else
		inote1 = tab_i(random(1, ftlen(gibid_chordfn) - 1), gibid_chordfn) - 24
		inote2 = inote1
		ifilter = random(30, 50)
	endif


	ifrq1 = 440 * exp(log(2) * (ifilter - 69) / 12)	; filter start freq.
	kamp linseg 1, p3*0.8, 1, p3*0.2, 0
	kcps line cpsmidinn(inote1), p3, cpsmidinn(inote2)
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
	a1 pareq a1, 200, 0.8, 0.7
	a1 = a1 * kamp * 0.8
	a1 *= 1-gkpump
	aL, aR pan2 a1, random(0.3, 0.7)
	;bus_mix("delay2", aL, aR)
	bus_mix("master", aL, aR)
endin


/*
	303 higher register melodics
*/
instr play_303b
	iamp = bid_getparameter(p4, p5, 2)
	ifilter = random(50, 90)
	inote = tab_i(random(1, ftlen(gibid_chordfn) - 1), gibid_chordfn) 

	ifrq1 = 440 * exp(log(2) * (ifilter - 69) / 12)	; filter start freq.
	kamp linseg 1, p3*0.8, 1, p3*0.2, 0
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
	a1 butterhp a1, 150
	a1 = a1 * kamp * 0.8
	a1 *= 1-gkpump
	aL, aR pan2 a1, random(0.3, 0.7)
	bus_mix("delay2", aL*0.3, aR*0.3)
	bus_mix("master", aL, aR)
endin


/*
	Delayed watery blip
*/
instr play_blip
	iamp = bid_getparameter(p4, p5, 2)
	a0 oscil 0.6, cpsmidinn(tab_i(1, gibid_chordfn)+48)
	kamp linseg 1, p3*0.1, 0, p3*0.9, 0
	a0 *= kamp
	aL, aR pan2 a0*iamp, random(0.3, 0.8)

	bus_mix("delay1", aL, aR)
	;bus_mix("master", aL, aR)
endin

/*
	Harsh clap
*/
instr play_clap
	iamp = bid_getparameter(p4, p5, 2)
	aL noise 1, 0.3
	aR noise 1, 0.4
	aL butterbp aL, 1200, 700
	aR butterbp aR, 1200, 700
	aL taninv aL*7
	aR taninv aR*7
	
	kamp linseg 2, p3, 0
	aL *= kamp * iamp
	aR *= kamp * iamp
	bus_mix("delay2", aL, aR)
	bus_mix("master", aL, aR)
	
endin


/*
	Closed lower frequency hi-hat
*/
instr play_hat1
	iamp = bid_getparameter(p4, p5, 2)
	idel = random(0.001, 0.02)
	xtratim idel
	p3 = random(0.02, 0.1)
	ifreq = (i(gksection) < 3) ? 600 : 840 ; 840
	aenv expsega .1, .0005, 1, p3 - .0005, .01
	asqr1 oscil 1, ifreq, gifnSquare, -1
	asqr2 oscil 1, ifreq*1.4471, gifnSquare, -1
	asqr3 oscil 1, ifreq*1.6170, gifnSquare, -1
	asqr4 oscil 1, ifreq*1.9265, gifnSquare, -1
	asqr5 oscil 1, ifreq*2.5028, gifnSquare, -1
	asqr6 oscil 1, ifreq*2.6637, gifnSquare, -1
	a808 sum asqr1, asqr2, asqr3, asqr4, asqr5, asqr6
	a808 butterhp a808, 4270
	a808 butterhp a808, 4270
	aout = a808 * aenv * iamp
	aout delay aout, idel
	if (i(gksection) == 1) then
		bus_mix("delay2", aout*0.9, aout*0.9)
	endif
	bus_mix("master", aout, aout)
endin


/*
	Open higher frequency hi-hat
*/
instr play_hat2
	iamp = bid_getparameter(p4, p5, 2)
	idel1 = random(0.005, 0.02)
	idel2 = random(0.005, 0.02)
	xtratim(max:i(idel1, idel2))
	p3 = 0.1
	kfreq line 1000, p3, 300
	aenv expsega .1, .0005, 1, p3 - .0005, .01
	asqr1 oscil 1, kfreq, gifnSquare, -1
	asqr2 oscil 1, kfreq*1.4471, gifnSquare, -1
	asqr3 oscil 1, kfreq*1.6170, gifnSquare, -1
	asqr4 oscil 1, kfreq*1.9265, gifnSquare, -1
	asqr5 oscil 1, kfreq*2.5028, gifnSquare, -1
	asqr6 oscil 1, kfreq*2.6637, gifnSquare, -1
	a808 sum asqr1, asqr2, asqr3, asqr4, asqr5, asqr6
	a808 butterhp a808, 3270
	a808 butterhp a808, 3270
	aout = a808 * aenv * iamp * 0.9
	aL delay aout, idel1
	aR delay aout, idel2
	bus_mix("master", aL, aR)
endin


/*
	Blocky square-ish FM chord clunk
*/
instr play_mel1
	iamp = bid_getparameter(p4, p5, 2)
	inote1 = tab_i(ftlen(gibid_chordfn) - 3, gibid_chordfn)
	inote2 = tab_i(ftlen(gibid_chordfn) - 4, gibid_chordfn)
	a1 foscil 0.46, cpsmidinn(inote1), 1, 2, 1, gifnSine
	a2 foscil 0.46, cpsmidinn(inote2), 1, 2, 1, gifnSine
	a1 += a2
	a1 butterhp a1, 130
	kenv linseg 1, p3*0.1, 0.6, p3*0.5, 0.4, p3*0.4, 0
	aout = a1*kenv*iamp*2
	aL, aR pan2 aout, random(0, 1)
	bus_mix("master", aL, aR)
	if (random(0, 1) > 0.77) then
		bus_mix("delay1", aL*0.9, aR*0.9)
	endif
endin


/*
	Lightly distorted 808 style kick
*/
instr play_kick	
	iamp = bid_getparameter(p4, p5, 2)

	idist = 0.35
	xtratim 0.1
	krelease release
	ktune init -1.4
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
	aout1 pareq amix, 100, 0.01, 0.7
	aout1 distort aout1, idist, gifnSine
	aout1 pareq aout1, 40, 3, 0.4
	aout1 pareq aout1, 130, 0.04, 0.6
	aout1 pareq aout1, 4900, 2, 0.7
	aout1 pareq aout1, 8900, 8, 0.7
	aout1 *= 2
	bus_mix("master", aout1, aout1)
endin


/*
	Heavily waveshape distorted clunky pseudo kick
*/
instr play_kick2
	iamp = bid_getparameter(p4, p5, 2)
	xtratim 0.1
	krelease release
	ktune random -1, 1
	ifn = gibid_chordgroups[1][1] ; gibid_chordfn
	ifreq = cpsmidinn(tab_i(1, ifn) - 24)
	kmul transeg 0.2, p3*0.5, -15, 0.01, p3*0.5, 0, 0
	kbend transeg 0.5, 1.2, -4, 0, 1, 0, 0
	;ifreq = 50*octave(ktune)
	asig gbuzz 0.5, ifreq*semitone(kbend), 20, 1, kmul, gifnCosine
	aenv transeg 1, p3-0.004, -6, 0
	gkpump = k(aenv)
	aatt linseg 0, 0.004, 1
	asig = asig*aenv*aatt
	aenv linseg 1, 0.07, 0
	acps expsega 400, 0.07, 0.001, 1, 0.001
	aimp oscili aenv, acps*octave(ktune*0.25)
	amix = ((asig*0.7)+(aimp*0.35))*2*iamp
	aout1 pareq amix, 100, 0.01, 0.6
	aout1 distort aout1, random(0.1, 0.7), gifnSaw
	aout1 pareq aout1, 100, 0.01, 0.3
	aout1 butterhp aout1, 80
	aout1 *= 5
	if (random(0, 1) > 0.5) then
		if (random(0, 1) > 0.7) then
			bus_mix("delay1", aout1*0.6, aout1*0.3)
		endif
		if (random(0, 1) > 0.7) then
			bus_mix("delay2", aout1*0.6, aout1*0.3)
		endif
	endif
	aout1 *= 1-gkpump
	bus_mix("master", aout1*0.7, aout1)
endin


/*
	Shaker
*/
instr play_shaker
	iamp = bid_getparameter(p4, p5, 2)
	idel1 = random(0.005, 0.02)
	idel2 = random(0.005, 0.02)
	xtratim(max:i(idel1, idel2))
	p3 = 0.05
	kfreq line 700, p3, 300
	aenv expsega .1, .0005, 1, p3 - .0005, .01
	asqr1 oscil 1, kfreq, gifnSaw, -1
	asqr2 oscil 1, kfreq*1.4471, gifnSaw, -1
	asqr3 oscil 1, kfreq*1.6170, gifnSaw, -1
	asqr4 oscil 1, kfreq*1.9265, gifnSaw, -1
	asqr5 oscil 1, kfreq*2.5028, gifnSine, -1
	asqr6 oscil 1, kfreq*2.6637, gifnSine, -1
	a808 sum asqr1, asqr2, asqr3, asqr4, asqr5, asqr6
	a808 butterhp a808, 2270
	a808 butterhp a808, 2270
	aout = a808 * aenv * iamp * 0.3 * (1-gkpump)
	aL delay aout, idel1
	aR delay aout, idel2
	bus_mix("master", aL, aR)
	bus_mix("delay1", aL*0.25, aR*0.25)
	
endin


/*
	Beef snare informed by original instrument by Istvan Varga
*/
instr play_snare
	icps0 = 111
	iamp = bid_getparameter(p4, p5, 2)
	p3 = random(0.03, 0.1)
	icps1 = 2.0 * icps0
	kcps port icps0, 0.007, icps1
	kcpsx = kcps * 1.5
  
	kfmd port 0.0, 0.01, 0.7
	aenv1 expon 1.0, 0.03, 0.5
	kenv2 port 1.0, 0.008, 0.0
	aenv2 interp kenv2
	aenv3 expon  1.0, 0.025, 0.5
  
	a_ oscili 1.0, kcps
	a1 oscili 1.0, kcps * (1.0 + a_*kfmd)
	a_ oscili 1.0, kcpsx
	a2 oscili 1.0, kcpsx * (1.0 + a_*kfmd)
 
	a3 unirand 2.0
	a3 = a3 - 1.0
	a3 butterbp a3, 3200, 1500
	a3 = a3 * aenv2
  
	a0 = a1 + a2*aenv3 + a3*1.0
	a0 = a0 * aenv1
	a0 butterhp a0, 210
	aout = a0*iamp
	bus_mix("master", aout, aout)

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
	Flutey chord
*/
instr chord1
	inote = p4
	iamp = p5
	aL fmpercfl 0.65, cpsmidinn(inote), 1, 2, 0.1, 10, gifnSine, gifnSquare, gifnSine, gifnSquare, gifnSine
	aR fmpercfl 0.65, cpsmidinn(inote), 1, 1.4, 0.2, 10, gifnSine, gifnSaw, gifnSine, gifnSquare, gifnSine
	aL butterhp aL, 340
	aR butterhp aR, 340
	aL butterlp aL, 4000
	aR butterlp aR, 4000
	kenv linseg 1, p3*0.5, 1, p3*0.4, 1, p3*0.1, 0
	aL *= kenv
	aR *= kenv
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
	Not really a crash, more just noise
*/
instr play_crash
	aL noise 1.7, 0.2
	aR noise 1.7, 0.3
	ifreq1 random 100, 1000
	ifreq2 random 7000, 12000
	if (random(0, 1) > 0.5) then
		istartfreq = ifreq1
		iendfreq = ifreq2
	else
		istartfreq = ifreq2
		iendfreq = ifreq1
	endif
	kfreq line 500, p3, 9000
	aL butterhp aL, kfreq
	aR butterhp aR, kfreq
	kenv linseg 0, p3*0.5, 1, p3*0.5, 0
	aL *= kenv
	aR *= kenv
	;bus_mix("master", aL, aR)
	bus_mix("delay1", aL, aR)
endin


/*
	Warped chord
*/
instr chord2
	inote = p4
	iamp = p5
	ilower = p6
	iamp = 0.55
	if (ilower == 1) then
		iamp = 1
	else
		inote += 12
	endif
	kfmod oscil 10, 6
	kfl linseg 1, p3*0.8, 1, p3*0.2, 0.1
	aL fmpercfl iamp, (cpsmidinn(inote)+kfmod)*kfl*0.5, 1, 2, 0.6, 10, gifnSine, gifnSquare, gifnSine, gifnSquare, gifnSine
	aR fmpercfl iamp, (cpsmidinn(inote)+kfmod)*kfl*0.5, 1, 1.4, 0.9, 10, gifnSine, gifnSaw, gifnSine, gifnSquare, gifnSine
	aL butterhp aL, 540
	aR butterhp aR, 540
	kenv line 0, p3, 1
	aL *= kenv
	aR *= kenv
	bus_mix("master", aL, aR)
endin


/*
	Play chord2 above, called from BID
*/
instr play_chord2
	iamp = bid_getparameter(p4, p5, 2)
	ilower = bid_getparameter(p4, p5, 4)
	index = 1  ; index 0 is chordgroup length
	while (index < ftlen(gibid_chordfn)) do
		event_i "i", "chord2", 0, p3, tab_i(index, gibid_chordfn), iamp, ilower
		index += 1
	od
	turnoff
endin


/*
	Organ type chord
*/
instr chord3
	inote = p4 - 12
	iamp = p5
	ifreq = cpsmidinn(inote)
	kfreq linseg 10, p3*0.4, ifreq, p3*0.6, ifreq
	aL fmb3 0.65, kfreq, 1, random(1.2, 2.2), random(0.1, 0.3), random(5, 15), gifnSine, gifnSquare, gifnSine, gifnSquare, gifnSine
	aR fmb3 0.65, kfreq, 1, random(1.2, 2.2), random(0.1, 0.3), random(5, 15), gifnSine, gifnSaw, gifnSine, gifnSquare, gifnSine
	aL butterhp aL, 340
	aR butterhp aR, 340

	kenv linseg 1, p3*0.95, 1, p3*0.05, 0
	aL *= kenv
	aR *= kenv
	bus_mix("master", aL, aR)
endin

/*
	Play chord3 above, called from BID
*/
instr play_chord3
	chordinstrument "chord3", p4, p5
	turnoff
endin


/*
	Retrigger sampler with appropriate pitching
*/
giglitchsamples = 44100
giglitchbufferL ftgen 0, 0, giglitchsamples, 7, 0
giglitchbufferR ftgen 0, 0, giglitchsamples, 7, 0
instr play_glitchread
	iamp = bid_getparameter(p4, p5, 2)
	ifreq = cpsmidinn(tab_i(random(1, ftlen(gibid_chordfn) - 1), gibid_chordfn))
	ilen = ((1/(ifreq))*sr)*pow(2, round(random(0, 4)))
	istart random 0, giglitchsamples-ilen
	awindex phasor giglitchsamples / ilen
	aL table awindex*giglitchsamples, giglitchbufferL
	aR table awindex*giglitchsamples, giglitchbufferR
	aL butterhp aL, 350
	aR butterhp aL, 350
	aL *= 0.2 * iamp
	aR *= 0.2 * iamp
	if (random(0, 1) > 0.7) then
		if (random(0, 1) > 0.5) then
			bus_mix("delay2", aL, aR)
		else
			bus_mix("delay2", aL, aR)
		endif
	endif
	bus_mix("master", aL, aR)
endin


#end
