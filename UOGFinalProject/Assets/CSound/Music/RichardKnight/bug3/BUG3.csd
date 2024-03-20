<CsoundSynthesizer>
<CsOptions>
-g -odac -m0 -n -d
</CsOptions>
<CsInstruments>
/*
	Debugger - Unfixed Bugs : BUG #3
	
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
gkpump = 0						; kick ducking control
gkreverse init 0			; global reverse

#include "wavetables.udo"	; general waveforms
#include "bussing.udo"		; global audio bussing
#include "src_hat909.udo"	; synthesised hi-hat for oprepare
#include "bid.udo"				; Bug Infested Directive tools and parsing
#include "oprepare.udo"		; offline preparation system
#include "effects.udo"		; audio effects
#include "instruments.udo"	; sound generators
#include "txt_tools.udo"	; text tools


/*
	Initialise the performance: run offline preparation and then call parseandrun
*/
instr bootstrap
	Sprepare[] fillarray "hat909"
	oprepare(Sprepare, "parseandrun")
	turnoff
endin


/*
	Parse BID file and run the sequencer
*/
instr parseandrun
	tt_notify("Parsing events")

	;bid_loadfile("bid_source.txt") ; file IO with readfi not supported in web IDE

	#include "bid_source.udo"
	bid_loadtext(SBID)

	tt_notify("Running sequencer")
	event_i "i", "sequencer", 0, 3600
	turnoff
endin


/*
	Initiate ending: fade out master and call complete notifier 
*/
instr endfade
	igain = i(gkmastergain)
	gkmastergain line igain, p3, 0
	event_i "i", "notify_change", p3, 1, -1
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
		tt_notify(sprintf("Complete, runtime: %s", tt_parsetime(itime)))
		exitnow
	else
		isectiontime = itime - gitimetrack
		tt_notify(sprintf("%s : section %d complete in %s", tt_parsetime(itime), isection, tt_parsetime(isectiontime)))
		gitimetrack = itime
	endif
	turnoff
endin


/*
	Global send effects: reverb
*/
instr global_reverb
	aL, aR bus_read "reverb"
	aL, aR freeverb aL, aR, 0.4, 0.3
	bus_mix("master", aL, aR)
endin


/*
	Global send effects: multitap delay
*/
instr global_mdelay 
	ibase1 = gibid_beattime
	ibase2 = ibase1 / 4
	aL, aR bus_read "mdelay"
	aLf init 0
	aRf init 0
	aL multitap aL+aLf, ibase1*3, 1, ibase1*6, 0.9
	aR multitap aR+aRf, ibase1*2, 1, ibase1*4, 0.9
	aLf = butterhp(aL, 400) * 0.4
	aRf = butterhp(aR, 400) * 0.4
	bus_mix("master", aL, aR)
endin


/*
	Master audio output
*/
instr global_master
	igain = 0.5
	aL, aR bus_read "master" 
	ilooptime = (60 / gibid_tempo) * 4

	if (gkreverse == 1) then
		aL butterhp aL, 150
		aR butterhp aR, 150
		if (changed:k(gkreverse) == 1 && random:k(0, 5) > 0.5) then
			aL, krecL sndloop aL, -1, gkreverse, ilooptime, 0
			aR, krecR sndloop aR, -1, gkreverse, ilooptime, 0
		endif
	endif
	aL limit aL*gkmastergain*igain, -1, 1
	aR limit aR*gkmastergain*igain, -1, 1
	outs aL, aR
endin


/*
	Core sequencer
*/
instr sequencer
	isection = 1
	event_i "i", "bid_setcurrentchord", 0, 1, isection, 0
	event_i "i", "global_reverb", 0, p3
	event_i "i", "global_mdelay", 0, p3
	event_i "i", "global_master", 0, p3
	kmetro metro (gibid_tempo / 60) * 4
	kposabs init 0
	kposchord init 0
	kpos init 0
	ksection init isection
	if (kmetro == 1) then
		if (ksection > gibid_maxsection) then
			event "i", "endfade", 0, gibid_beattime*8
			turnoff
		endif

		; sequence BID elements accordingly
		bid_seq "chord1", kpos, ksection
		bid_seq "chord2", kpos, ksection
		bid_seq "chord3", kpos, ksection
		bid_seq "bass", kpos, ksection
		bid_seq "hat909", kpos, ksection
		bid_seq "hat909c", kpos, ksection
		bid_seq "clap909", kpos, ksection
		bid_seq "kick", kpos, ksection
		bid_seq "rim", kpos, ksection  
		bid_seq "mel1", kpos, ksection
		bid_seq "303", kpos, ksection

		if (kpos < 31) then
			kpos += 1
		else
			kpos = 0
		endif
		
		ksection16ths = bid_getsectionlength(ksection) * 4

		if (ksection != 7 && kposabs+16 > ksection16ths) then
			gkreverse = 1
		endif
		
		if (kposabs+1 < ksection16ths) then
			kposabs += 1
		else
			event "i", "notify_change", 0, 1, ksection
			event "i", "play_crash", 0, random:k(0.5, 2)
			gkreverse = 0
			ksection += 1
			kposabs = 0
			kposchord = 0
			event "i", "bid_setcurrentchord", 0, 1, ksection, 0  ; is 0 correct here?
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
i"bootstrap" 0 1
</CsScore> 
</CsoundSynthesizer>