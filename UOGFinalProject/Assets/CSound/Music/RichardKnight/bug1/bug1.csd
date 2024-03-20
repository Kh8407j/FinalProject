<CsoundSynthesizer>
<CsOptions>
-m0 -d -odac -n
</CsOptions>
<CsInstruments>
/*

	Debugger - Unfixed Bugs - BUG1

	By Richard Knight 2019-2020
	http://1bpm.net
*/

sr = 44100
ksmps = 10
nchnls = 2
0dbfs = 35000

; general globals
zakinit 4, 1
seed 0
gkpump init 0

; chords to be used
ginotes1[] fillarray 440, 493.88, 587.33, 659.25, 698.46, 830.61
ginotes2[] fillarray 493.88, 554.37, 587.33, 698.46, 783.99


/* chorus udo by bhob rainey */
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
	adel vdelay3 ain/(inumvoice * 0.5), (kdelay + alfo) * 1000, 1000
	al = ainl + adel * incr * icount
	ar = ainr + adel * (1 - incr * icount)
	xout al, ar
endop


/* glitch subsequencer A1 */
instr 1
	istart = 0
	while istart < p3 do
		idur random p3*0.005, p3*0.1
		iprtc random 20, 1000
		event_i "i", 10, istart, idur, iprtc*0.0001
		idur2 random idur *1.1, idur *2
		istart = istart + idur2
	od
endin


/* glitch subsequencer A2 */
instr 10
	istart = 0
	;ifreq = 880;random 300, 1000
	irand random 1, 10
	ifreq = 110 * irand
	iwav random 1, 4
	while istart < p3 do
		event_i "i", 100, istart, p4, ifreq, iwav
		istart = istart + p4*0.5
		
	od
endin


/* glitch tone */
instr 100
	ifreqshift1 random -3, 3
	ifreqshift2 random -3, 3
	k1 linseg 1,  0.01, 0
	inull = p5 ; just to supress warning
	a1 oscil 2500, p4, 1;p5
	a2 oscil 2500, p4+ifreqshift1, 1;p5
	a3 oscil 2500, p4+ifreqshift2, 1;p5
	irf1 random 300, 16000
	irf2 random 300, 16000
	aL = (a1*k1) + (a2*k1*0.7)
	aR = (a1*k1) + (a3*k1*0.7)
	aL butterlp aL, irf1
	aR butterlp aR, irf2
	zawm aL, 1
	zawm aR, 2
endin


/* blip tone */
instr 101 
	ifreqshift1 random -10, 10
	ifreqshift2 random -10, 10
	k1 linseg 0, p3*0.3, 1, p3*0.4, 1, p3*0.3, 0
	a1 oscil 1000, p4, p5
	a2 oscil 1000, p4+ifreqshift1, p5
	a3 oscil 1000, p4+ifreqshift2, p5
	zawm (a1*k1) + (a2*k1*0.7), 1
	zawm (a1*k1) + (a3*k1*0.7), 2
endin


/* glitch subsequencer B1 */
instr 2
	istart = 0
	while istart < p3 do
		event_i "i", 100, istart, 0.01, p4, p5
		istart = istart + 0.05
	od
endin


/* master outputs */
instr 800 
	aL zar 3 
	aR zar 4
	;aL compress aL, aL, -1, 30, 60, 1.2, 0.1, 0.01, 0.01
	;aR compress aR, aR, -1, 30, 60, 1.2, 0.1, 0.01, 0.01
	outs aL*0.9, aR*0.9
	zacl 3, 4
endin


/* regular output */
instr 801
	aL zar 1
	aR zar 2
	zawm aL, 3
	zawm aR, 4
	zacl 1, 2
endin


/* reversey output */
instr 802
	aL zar 1
	aR zar 2
	a1L, krecL sndloop aL, -1, 1, 1, 0.5
	a1R, krecR sndloop aR, -1, 1, 1, 0.5
	zawm a1L, 3
	zawm a1R, 4
	zacl 1, 2
endin


/* delay feedback out */
instr 803
	aL zar 1
	aR zar 2
	idiv = 0.25 ; 0.0625
	kamp linseg 1, idiv, 0, p3-idiv, 0
	apL = aL*kamp
	apR = aR*kamp
	adL init 0
	adR init 0
	adL delay apL + (adL*0.8), idiv
	adR delay apR + (adR*0.8), idiv
	zawm apL+adL, 3
	zawm apR+adR, 4
	zacl 1, 2
endin


/* kick */
instr 901
	kax linseg 300, p3*0.05, 100, p3*0.1, 40, p3*0.8, 20
	kenv linseg 1,p3*0.2,0.6,p3*0.2,0.4,p3*0.2,0.1,p3*0.2,0
	kpit linseg 500, p3*0.2, 100, p3*0.4, 40, p3*0.2, 30, p3*0.2, 20
	a2 oscil 8500,kpit*0.35,1
	a3 oscil 9500,kpit*0.2,1
	an noise 3000,-0.1
	ax1 oscil 300, 400, 1
	ax2 oscil 80, 900, 1
	kaxenv linseg 0.2, p3*0.02, 0
	akx = (ax1*ax2)*kaxenv
	 
	aout = a2+a3 ; + ax
	gkpump = kenv
	amix = p4*((aout*kenv)+akx)
	adist distort amix, 0.13, 1
	aeq1 pareq adist, 70, 1.5, 2
	aeq2 pareq aeq1, 200, 0.7, 0.9 
	aout pareq aeq2, 5000, 1.8, 0.5
	zawm aout*0.7, 1
	zawm aout*0.7, 2 
endin


/* clap */
instr 902
	k1 linseg 1, p3*0.1, 0, p3*0.1, 1, p3*0.1, 0, p3*0.1, 1, p3*0.2, 0, p3*0.1, 1, p3*0.3, 0
	a1 noise 10000, 0.5
	a2 noise 10000, -0.5
	a3 butterbp a1, 1000, 1800
	a4 butterbp a2, 1000, 1800
	a5 pareq a3, 400, 3.5, 0.5
	a6 pareq a4, 400, 3.5, 0.5
	zawm a5*k1*1.5, 1
	zawm a6*k1*1.5, 2
endin


/* clap b */
instr 9020
	k1 linseg 1, p3*0.1, 0, p3*0.1, 1, p3*0.1, 0, p3*0.1, 1, p3*0.2, 0, p3*0.1, 1, p3*0.3, 0
	a1 noise 10000, 0.1
	a2 noise 10000, -0.1 
	a3 butterlp a1, 1600
	a4 butterlp a2, 1600
	a5 pareq a3, 300, 1.5, 0.5
	a6 pareq a4, 300, 1.5, 0.5
	zawm a5*k1*1.5, 1
	zawm a6*k1*1.5, 2
endin


/* hi hat */
instr 903 
	ifreqshift1 random 9, 11
	ifreqshift2 random 9, 11 
	kpt1 linseg 1, p3*0.2, 0.8, p3*0.2, 1.2, p3*0.2, 0.8, p3*0.2, 1.2, p3*0.2, 0.8
	k1 line p4, p3, 0
	a1 noise 9000, 0.1
	a2 noise 9000, 0.1
	a3 butterhp a1, 10000
	a4 butterhp a2, 10000
	as1 oscil 4000, 7000*(ifreqshift1*0.1)*p5, 1
	as2 oscil 4000, 8000*p5*kpt1, 1
	as3 oscil 4000, 12000*p5*kpt1, 1
	as4 oscil 4000, 16000*(ifreqshift2*0.1)*p5, 1
	aL = a3 + as1 + as3
	aR = a4 + as2 + as4
	zawm aL*k1*0.93, 1
	zawm aR*k1*0.93, 2
endin


/* fm bell */
instr 904
	irand1 random 1, 100
	irand2 random 1, 100
	irfreq1 random 600, 19000
	irfreq2 random 600, 19000
	k1 line irand1*0.1, p3, irand2*0.1
	k2 linseg p5, p3*0.4, 0.4, p3*0.6, 0
	a1 fmbell 8000, p4, k1, 4, 0, 0, 1, 1, 1, 1, 4
	a2 fmbell 8000, p4, k1, 2, 0, 0, 1, 1, 1, 3, 4
	a1 butterlp a1, irfreq1
	a2 butterlp a2, irfreq2
	zawm a1*k2*0.9, 1
	zawm a2*k2*0.9, 2
	irand random 0, 100
	if (irand > 80) then
		idur random 10, 100
		event_i "i", 904, idur*0.005, idur*0.001, p4*2, p5*0.5
	endif
endin


/* fm rhode */
instr 905
	ifreq random 600, 22050
	irand1 random 1, 100
	irand2 random 1, 100
	k1 line irand1*0.1, p3, irand2*0.1
	k2 linseg p5, p3*0.4, 0.4, p3*0.6, 0
	a1 fmrhode 8000, p4, k1, 4, 0, 0, 1, 1, 1, 1, 4
	a2 fmrhode 8000, p4, k1, 2, 0, 0, 1, 1, 1, 3, 4
	a3 butterlp a1, ifreq
	a4 butterlp a2, ifreq
	zawm a3*k2*0.5, 1
	zawm a4*k2*0.5, 2
endin


/* fm wurlie */
instr 906
	ifreq random 600, 4000
	irand1 random 1, 100
	irand2 random 1, 100
	k1 line irand1*0.1, p3, irand2*0.1
	k2 linseg p5, p3*0.3, 0.2, p3*0.7, 0
	a1 fmwurlie 8000, p4, k1, 4, 0, 0, 1, 3, 1, 1, 4
	a2 fmwurlie 8000, p4, k1, 2, 0, 0, 1, 1, 1, 3, 4
	a3 butterlp a1, ifreq
	a4 butterlp a2, ifreq
	zawm a3*k2*0.9, 1
	zawm a4*k2*0.9, 2
endin


/* filter rhodey */
instr 907
	ifn random 1, 4
	kfq oscili 0.5, p5, ifn
	a1 fmrhode 8000, p4, 4, 8, 0, 0, 1, 1, 3, 1, 4
	a2 fmrhode 8000, p4, 8, 4, 0, 0, 1, 3, 1, 1, 4
	a3 butterlp a1, 200 * (kfq + 0.5)
	a4 butterlp a2, 200 * (kfq + 0.5)
	aL, aR ensembleChorus a3, 0.005, 0.005, 0.1, 0.6, 4, 1
	
	zawm 0.6 * (aL + a3), 1
	zawm 0.6 * (aR + a4), 2
endin


/* bass */
instr 908
	k1 linseg 2.1, p3*0.2, 2, p3*0.8, 2
	k2 line 10, p3, 0
	iamp random 500, 800
	kamp linseg iamp*0.001, p3*0.1, 0.5, p3*0.9, 0
	aL foscil 8000, p4, 4, k1, k2, 1
	aR foscil 8000, p4, 3.9, k1, k2, 1
	aL1 pareq aL, 440, 0.4, 0.7 
	aR1 pareq aR, 440, 0.4, 0.7
	zawm aL1 * kamp, 1
	zawm aR1 * kamp, 2
endin


/* filter rhodey */
instr 909
	ifn random 1, 4
	kfq oscili 0.5, p5 * 4, ifn
	kpt line p4, p3, p4*1.1
	a1 fmrhode 8000, kpt, 4, 8, 0, 0, 1, 1, 3, 1, 4
	a2 fmrhode 8000, kpt, 8, 4, 0, 0, 1, 3, 1, 1, 4
	a3 butterlp a1, 200 * (kfq + 0.5)
	a4 butterlp a2, 200 * (kfq + 0.5)
	aL, aR ensembleChorus a3, 0.005, 0.005, 0.1, 0.6, 4, 1
	
	zawm 0.8 * (aL + a3), 1
	zawm 0.8 * (aR + a4), 2
endin


/* crasher */
instr 910
	kflt linseg 1, p3*0.4, 0.1, p3*0.6, 0
	aL noise 900, 0.9 
	aR noise 900, -0.1
	kfq1 oscili 5, 14000, 2
	kfq2 oscili 10, 15000, 4
	aL1 butterlp aL, 22050*kflt
	aR1 butterlp aR, 22050*kflt
	kamp linseg 1, p3*0.1, 0.2, p3*0.7, 0.05, p3*0.2, 0
	aL = aL1*kfq1*kfq2*0.5*kamp
	aR = aR1*kfq1*kfq2*0.5*kamp
	aLr comb aL, 1, 0.12
	aRr comb aL, 1, 0.1 

	zawm aL+aLr, 1
	zawm aR+aRr, 2
endin


/* stochastic sequencer */
instr 999
	ipos = 0
	iseq = 0
	ieven = 0
	ibeatlength = 0.125
	
	; create mixer items
	;	master outs
	event_i "i", 800, 0, p3

	; standard mixer
	event_i "i", 801, 0, p3 - 2

	; reverse, delay thing or offbeat kick - last two bars of each section
	irand random 0, 100
	if (irand > 50) then
		event_i "i", 802, p3 - 2, 2
	elseif (irand < 90) then
		event_i "i", 803, p3 - 2, 2
	else
		event_i "i", 801, p3 - 2, 2
		event_i "i", 901, p3 - (ibeatlength * 2), 0.15, 1
	endif
	

	; create score items
	ipos = 0
	while ipos < p3 do

		; arrange the shuffle
		if (iseq == 1 || iseq == 3) then
			iposadj = ipos + 0.05
		else
			iposadj = ipos
		endif


		; crasher
		if (ipos == 0 && (p4 == 3 || p4 == 4 || p4 = 5)) then
			event_i "i", 910, iposadj, 4
		endif

		; bass
		irand random 0, 100
		ilastbass = -1
		if (irand > 70 && (p4 == 3 || p4 == 4 || p4 == 5)) then
			irandindex random 0, lenarray(ginotes1) - 2
			ifreq = ginotes1[irandindex] * 0.05
			if (ifreq != ilastbass) then ; eh, sounds to be doing it
				event_i "i", 908, iposadj, 0.2, ifreq
				ilastbass = ifreq
			endif
		elseif (iseq == 2 && ieven == 1 && irand > 60) then
			event_i "i", 908, iposadj, 0.1, ginotes2[1] * 0.025

		endif

		; kick
		irand random 0, 100
		if (iseq == 0) then
			iamp random 0, 1000
			event_i "i", 901, iposadj, 0.12, 1
			irand random 0, 100
			if (irand > 90) then
				event_i "i", 901, iposadj+ibeatlength+0.05, 0.45, iamp*0.0005
			endif
		endif
		
		; clap syncop
		irand random 0, 100
		if (irand > 90 && (iseq == 1 || iseq == 3)) then
			event_i "i", 9020, iposadj, 0.02
		endif

		; clap regular
		if (iseq == 0 && ieven == 1 && p4 >= 3) then
			event_i "i", 902, iposadj, 0.05
		endif

		; hat regular
		if (iseq == 2) then
			ilen = 0.02
			iamp =0.9
			if (p4 == 3) then
				iamp = 0.6
				ilen = 0.1
			endif
			event_i "i", 903, iposadj, ilen, iamp, 1.2
		endif

		; hat
		irand random 0, 100
		if (irand > 50 && (p4 == 0 || p4 == 1 || p4 == 2)) then
			iamp random 0, 1000
			event_i "i", 903, iposadj, 0.00, iamp*0.001, 1
			irand random 0, 100
			if (irand > 90) then
				event_i "i", 903, iposadj + 0.05, 0.01, iamp*0.0008, 1
			endif
		endif

		; triglitch
		irand random 0, 100
		if (irand > 85 && (p4 == 1 || p4 == 2 || p4 == 4)) then
			idur random 10, 100
			;event_i "i", 10, iposadj, 0.1 ;idur*0.01  ;i1 retrigs
			iprtc random 20, 1000
			event_i "i", 10, iposadj, idur*0.001, iprtc*0.0001
		endif

		; tone
		irand random 0, 100
		if (irand > 75 && (p4 == 0 || p4 == 1 || p4 == 2 || p4 == 5 || p4 == 8)) then
			iwin random 1, 4
			irandindex random 0, lenarray(ginotes1) - 1
			ifreq = ginotes1[irandindex]
			event_i "i", 100, iposadj, 0.2, ifreq, iwin
		endif

		; fm rhode onbeat regular
		if (ieven == 0 && iseq = 0 && (p4 == 3 || p4 == 5)) then
			iplay = 1
			if (p4 == 5) then
				irandplay random 0, 100
				if (irandplay < 80) then
					iplay = 0
				endif
			endif

			if (iplay == 1) then

				irand random 0, 100
				if (irand > 20) then
					inst = 907
				else
					inst = 909   
				endif
				
				index = 0
				imod random 400, 4000
				until index == lenarray(ginotes2) do
					ifreq = ginotes2[index]
					event_i "i", inst, iposadj, 0.5, ifreq, imod * 0.001
					index += 1
				od
			endif
		endif

		; fm rhode
		irand random 0, 100
		if (irand > 90 && (((iseq == 0 || iseq == 2) && (p4 == 2 || p4 == 4)) || ((iseq == 1 || iseq == 3) && (p4 == 3 || p4 == 6)))) then
			idur random 10, 100
			index = 0
			until index == lenarray(ginotes1) do
				ifreq = ginotes1[index]
				event_i "i", 905, iposadj, idur*0.001, ifreq, 1
				index += 1
			od
		endif

		; fm rhode off
		irand random 0, 100
		if (irand > 90 && (iseq == 1 || iseq == 3) && (p4 == 1 || p4 == 2 || p4 == 6 || p4 == 7)) then
			idur random 10, 100
			index = 0
			until index == lenarray(ginotes2) do
				ifreq = ginotes2[index]
				event_i "i", 906, iposadj, idur*0.001, ifreq, 1
				index += 1
			od
		endif

		; bell tone
		irand random 0, 100
		if (irand > 85 && (iseq == 1 || iseq == 3) && (p4 == 1 || p4 == 2 || p4 == 4 || p4 = 7)) then
			idur random 10, 100
			irandindex random 0, lenarray(ginotes1) - 1
			ifreq = ginotes1[irandindex]
			event_i "i", 904, iposadj, idur*0.001, ifreq, 1
		endif


		; increment beat position
		ipos = ipos + ibeatlength
		
		; increment beat per bar count or reset
		if (iseq == 3) then
			iseq = 0
		else
			iseq = iseq + 1
		endif

		; switch even/odd bar
		if (ieven == 0 && iseq == 0) then
			ieven = 1
		elseif (ieven == 1 && iseq == 0) then
			ieven = 0
		endif

	od
endin

</CsInstruments>
<CsScore>
f1 0 16384 10 1                                          ; Sine
f2 0 16384 10 1 0.5 0.3 0.25 0.2 0.167 0.14 0.125 .111   ; Sawtooth
f3 0 16384 10 1 0   0.3 0    0.2 0     0.14 0     .111   ; Square
f4 0 16384 10 1 1   1   1    0.7 0.5   0.3  0.1          ; Pulse


i999 0 32 0
i999 32 32 1
i999 64 32 2
i999 96 32 4
i999 128 32 4
i999 160 64 3
i999 224 32 5
i999 256 32 6
i999 288 32 7
i999 320 32 8

i910 352 5
i800 352 5
i801 352 5


</CsScore>
</CsoundSynthesizer>