<CsoundSynthesizer>
<CsOptions>
-m0 -odac -n -d
</CsOptions>
<CsInstruments>
/*

	Debugger - Unfixed Bugs - BUG2
	
	By Richard Knight 2019-202

	http://1bpm.net

*/

sr = 44100
kr = 4410
ksmps = 10
nchnls = 2
0dbfs = 1

; globals
seed 0
zakinit 2, 2


/* clicks */
instr 1	
	kb1 line 0.999, p3, -0.999
	kb2 line -0.999, p3, 0.999
	a1 noise 5000, kb1
	a2 noise 5000, kb2
	a3 clip a1, 0, 1
	a4 clip a2, 0, 1
	a5 butterhp a3, p5
	a6 butterhp a3, p5
	kamp linseg 1, p3*0.1, 0.1, p3*0.9, 0
	ipan random 0, 1000
	zawm a5*kamp*p4*(ipan*0.001), 1
	zawm a6*kamp*p4*(1-(ipan*0.001)), 2
endin


/* blip */
instr 2
	irandL random 0, 1000
	irandR random 0, 1000
	irandA random 10, 200
	a1 oscili irandA*0.001, p4, 1
	zawm a1*(irandL * 0.001), 1
	zawm a1*(irandR * 0.001), 2
endin


/* master out */
instr 9000
	aL zar 1
	aR zar 2
	outs aL*0.9, aR*0.9
	zacl 1, 2
endin

/* stochastic subsequencer */
instr 901
	irnd1 random 10, 1000
	idur = irnd1 * 0.0001
	ipos = 0
	ihpf random 500, 16000
	while (ipos <= p3) do
		irnd2 random 0, 100
		iamp random 100, 1000
		if (irnd2 > 70) then
			event_i "i", 1, ipos, idur*0.1, iamp*0.001, ihpf
		endif

		irnd2 random 0, 100
		if (irnd2 > 99) then
			ifreq random 4000, 17000
			event_i "i", 2, ipos, idur*3, ifreq
		endif 

		ipos += idur

	od

	event_i "i", 9000, 0, p3
endin


/* main stochastic sequencer */
instr 999
	ipos = 0
	while (ipos <= p3) do
		idur random 1, 5
		event_i "i", 901, ipos, idur
		ipos += idur*0.5
	od

endin

</CsInstruments>
<CsScore>
f1 0 16384 10 1
i999 0 200

</CsScore>
</CsoundSynthesizer>

