<CsoundSynthesizer>
<CsOptions>
-odac -m0 -n -d
</CsOptions>
<CsInstruments>
/*
	Debugger - Unfixed Bugs : BUG #4
	
	http://git.1bpm.net/csd-unfixedbugs1/about/

	By Richard Knight 2021
		http://1bpm.net
		q@1bpm.net

*/

sr = 44100
ksmps = 100
nchnls = 2
0dbfs = 1
seed 0

#define NOFILEIO ## 		; file IO with readfi not supported on all platforms: disables bid_loadfile

gkmastergain init 1		; master gain
gkpump = 0			; kick ducking control
gksection init -1

#include "wavetables.udo"	; general waveforms
#include "bussing.udo"		; global audio bussing
#include "bid.udo"		; Bug Infested Directive tools and parsing
#include "instruments.udo"	; sound generators
#include "txt_tools.udo"	; text tools


/*
	Global delay instrument 1
*/
instr global_delay1
	aL, aR bus_read "delay1"
	ifreq1 = (gibid_tempo / 60) / 8
	kfdbkL = abs(oscil(0.8, 1.63))
	kfdbkR = abs(oscil(0.8, 1.67))

	atimeL = abs(oscil(0.2, ifreq1)) + 0.01
	atimeR = abs(oscil(0.2, ifreq1)) + 0.01

	aLdlr delayr 1
	aLdel deltapi atimeL
	aLdel butterhp aLdel, 130
	delayw aL + (aLdel * kfdbkL)

	aRdlr delayr 1
	aRdel deltapi atimeR
	aRdel butterhp aRdel, 130
	delayw aR + (aRdel * kfdbkR)

	aLdel *= 1-gkpump
	aRdel *= 1-gkpump
	bus_mix("master", aLdel, aRdel)
endin


/*
	Global delay instrument 2
*/
instr global_delay2
	aL, aR bus_read "delay2"
	aLdlr delayr 0.2
	kdeltime = abs(oscil(0.02, 0.04)) + 0.01
	aLdel deltapi kdeltime + 0.002
	delayw aL + (aLdel * 0.7)
	aRdlr delayr 0.2
	aRdel deltapi kdeltime + 0.001
	delayw aR + (aRdel * 0.7)
	bus_mix("master", aLdel, aRdel)
endin


/*
	Master audio output
*/
instr global_master
	igain = 1
	aL, aR bus_read "master"

	awindex phasor giglitchsamples/sr
	tablew aL, awindex*giglitchsamples, giglitchbufferL
	tablew aR, awindex*giglitchsamples, giglitchbufferR

	if (gksection == 1 || gksection == 2) then
		aL butterhp aL, 100
		aR butterhp aR, 100
	elseif (gksection == 8) then
		islen = tab_i(8, gibid_sectionlengths)*gibid_beattime
		khpf linseg 0, islen*0.5, 0, islen*0.2, 30, islen*0.2, 60, islen*0.1, 1000
		aL butterhp aL, khpf
		aR butterhp aR, khpf
	endif

	
	aL limit aL*0.5, -1, 1
	aR limit aR*0.5, -1, 1
	outs aL*gkmastergain*igain, aR*gkmastergain*igain
endin


/*
	Print notification of performance time since last notification
		or if isection is -1, print completion notification
*/
gitimetrack times
instr notify_change
	isection = p4
	itime times
	if (isection == -1) then
		tt_notify(sprintf"Complete, runtime: %s", tt_parsetime(itime)))
		exitnow
	else
		isectiontime = itime - gitimetrack
		tt_notify(sprintf("%s : section %d complete in %s", tt_parsetime(itime), isection, tt_parsetime(isectiontime)))
		gitimetrack = itime
	endif
	turnoff
endin


/*
	Parse BID file and run the sequencer
*/
instr parseandrun
	tt_notify("Parsing events")

	#include "bid_source.udo"
	bid_loadtext(SBID)

	tt_notify("Running sequencer")
	event_i "i", "sequencer", 0, 3600
	turnoff
endin



/*
	Sequence BID elements
*/
instr sequencer
	isection = 1
	event_i "i", "bid_setcurrentchord", 0, 1, isection, 0
	event_i "i", "global_master", 0, p3
	event_i "i", "global_delay1", 0, p3
	event_i "i", "global_delay2", 0, p3
	kmetro metro (gibid_tempo / 60) * 4
	kpos init 0
	kposabs init 0
	ksection init isection
	kposchord init 0
	gksection = ksection
	if (kmetro == 1) then
		if (ksection > gibid_maxsection) then
			event "i", "notify_change", p3, 1, -1
			turnoff
		endif

		; sequence BID elements
		bid_seq "kick", kpos, ksection
		bid_seq "kick2", kpos, ksection
		bid_seq "clap", kpos, ksection
		bid_seq "blip", kpos, ksection
		bid_seq "303", kpos, ksection
		bid_seq "hat1", kpos, ksection
		bid_seq "chord1", kpos, ksection
		bid_seq "chord2", kpos, ksection
		bid_seq "chord3", kpos, ksection
		bid_seq "snare", kpos, ksection
		bid_seq "mel1", kpos, ksection
		bid_seq "hat2", kpos, ksection
		bid_seq "303b", kpos, ksection
		bid_seq "shaker", kpos, ksection
		bid_seq "glitchread", kpos, ksection

		kpos = (kpos < 31) ? kpos + 1 : 0
		ksection16ths = bid_getsectionlength(ksection) * 4

		if (kposabs+1 < ksection16ths) then
			kposabs += 1
		else
			event "i", "notify_change", 0, 1, ksection
			event "i", "play_crash", 0, gibid_beattime
			ksection += 1
			kposchord = 0
			kpos = 0
			kposabs = 0
			event "i", "bid_setcurrentchord", 0, 1, ksection, 1
		endif
		
		
		if (kposchord+1 < gkbid_chordlength*4) then
			kposchord += 1
		else
			kposchord = 0
			event "i", "bid_setcurrentchord", 0, 1, ksection, 1
		endif
		

	endif

endin

</CsInstruments>
<CsScore>
i"parseandrun" 0 1
</CsScore>
</CsoundSynthesizer>