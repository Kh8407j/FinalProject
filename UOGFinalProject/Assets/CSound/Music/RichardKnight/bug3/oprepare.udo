#ifndef UDO_OPREPARE
#define UDO_OPREPARE ##
/*
	Debugger - Unfixed Bugs : BUG #3

	Offline preparation system: record a sound in one k-cycle to a ftable for future use
	To be used where online playback would be too CPU heavy
	In the case of BUG3, it is used for the 909 hi-hat

	Instruments to be prepared should be prepended with src_
*/


/*
	Internal preparation instrument: loop through gSoprepare
	p4	index of gSoprepare to process
	p5	instrument name to schedule when all sounds have been prepared
*/
gSoprepare[] init 1 		; filled by oprepare opcode: input instrument names without src_ prepended
giopreparedfns[] init 1		; filled by oprepare opcode: output ftable numbers corresponding to above
instr _oprepare
	iprepareindex = p4
	SonComplete = p5
	if (iprepareindex >= lenarray(gSoprepare)) then
		event_i "i", SonComplete, 0, 3600
		turnoff
	else 
		Sprepareinstr = gSoprepare[iprepareindex]
		Srcinstr = sprintf("src_%s", Sprepareinstr)
		ilen = 0.3
		p3 = ilen
		ifn ftgen 0, 0, sr*ilen, 7, 0
		giopreparedfns[iprepareindex] = ifn
		ktimek timeinstk
		if (ktimek == 1) then
			kcycles = ilen * kr
			kcount init 0
loop:
			apos phasor (1/(ftlen(ifn)/sr))
			aproc subinstr Srcinstr, 1, 0.1
			tabw aproc, apos, ifn, 1
			loop_lt kcount, 1, kcycles, loop
		elseif (ktimek == 5) then
			scoreline_i sprintf("i\"_oprepare\" 0 1 %d \"%s\"", iprepareindex+1, SonComplete)
			turnoff
		endif
	endif
	
endin


/*
	Start the offline preparation

	oprepare Snames[], SonComplete

	Snames[]	list of instruments to process (instrument name without src_ prepended)
	SonComplete	instrument to be scheduled when preparation process has completed
*/
opcode oprepare, 0, S[]S
	Snames[], SonComplete xin
	gSoprepare = Snames
	giopreparedfns[] init lenarray(Snames)
	scoreline_i sprintf("i\"_oprepare\" 0 1 0 \"%s\"", SonComplete)
endop


/*
	Get the ftable number of a specified instrument name as originally passed to oprepare

	ifn oprepare_getfn Sname

	ifn	the ftable
	Sname	name of offline-prepared instrument
*/
opcode oprepare_getfn, i, S
	Sname xin
	ifn = -1
	index = 0
	while (index < lenarray(gSoprepare)) do
		if (strcmp(gSoprepare[index], Sname) == 0) then
			ifn = giopreparedfns[index]
		endif
		index += 1
	od
complete:
	xout ifn
endop


#end

