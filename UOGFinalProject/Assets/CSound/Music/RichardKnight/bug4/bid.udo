#ifndef UDO_BID
#define UDO_BID ##
/*
	Debugger - Unfixed Bugs : BUG #4

	Bug Infested Directive file parser v1 and tools

	Designed to create a reusable loop based score format in the Unfixed Bugs project and beyond.
*/


#define BID_VERSION #1.0#

#include "txt_tools.udo"

; globals
gibid_tempo init -1		; beats per minute
gibid_beattime init -1		; time of one beat in second
gibid_maxsection init -1	; max number of sections
gibid_chordfn init -1		; current chord ftable
gkbid_chordlength init -1	; current chord length

; BID internals
gibid_sectionlengths ftgen 0, 0, -64, -7, 0	; section lengths
gibid_sections[][] init 64, 64		; section pointers to data
gibid_sectiondata[][] init 99, 6	; section data, ftables contained

gibid_chordgroups[][] init 16, 12	; chord groups, pointers to sectionchords by section
gibid_sectionchords[] init 16		; ftables of section chords

gibid_currentchordnum = 0	; current chord number
gibid_lastchordgroup = -1	; last chord group
gibid_lastsection = -1		; last section

gSbid_sequenced[] init 1	; internal tracking of sequenced elements
gibid_sequenceinit init 1	; internal tracking of sequenced init
gibid_swingtime init -1		; swing time calculated from percent

/*
	Get BID instrument index, creating new reference if specified.
	Internal use only.
	
	index _bid_gettextindex Sname, [iaddifnotexists = -1]

	index			BID instrument index

	Sname			name to look up or create
	iaddifnotexists		1=create , default=fatal if not exists
*/
opcode _bid_gettextindex, i, Sj
	Sname, iaddifnotexists xin
	ifinalindex = -1
	index = 0
	while (index < lenarray(gSbid_sequenced)) do
		if (strcmp(gSbid_sequenced[index], Sname) == 0) then
			ifinalindex = index
			igoto complete
		endif
		index += 1
	od

	if (iaddifnotexists == 1) then
		if (gibid_sequenceinit == 1) then
			gibid_sequenceinit = 0
			SequencedNew[] fillarray Sname
			ifinalindex = 0
		else
			SequencedNew[] init lenarray(gSbid_sequenced) + 1
			index = 0
			while (index < lenarray(gSbid_sequenced)) do
				SequencedNew[index] = gSbid_sequenced[index]
				index += 1
			od
			SequencedNew[index] = Sname
			ifinalindex = index
		endif
		gSbid_sequenced = SequencedNew
		igoto complete
	else
		tt_notify_fatal(sprintf("Sequenced index for '%s' not found", Sname))
	endif

complete:
	xout ifinalindex
endop



/*
	Parse a row of comma-separated numerical values of either patterns or chords.
	Internal use only.
	
	inum _bid_parserowitems Sline, ix1, ix2, imode

	inum	number of elements found parsed 

	Sline	input line
	ix1	array dimension 1 index
	ix2	array dimension 2 index
	imode	0=count elements; 1=write patterns; 2=write chords
*/
opcode _bid_parserowitems, i, Siii
	Sline, ix1, ix2, imode xin
	inum = 0
	while (strlen(Sline) > 0) do
		icomma = strindex(Sline, ",")
		Stemp = strsub(Sline, 0, icomma)
		icomma = (icomma == -1) ? 0 : icomma
		Sline = strsub(Sline, icomma + 1)
		if (imode == 1) then
			tabw_i strtod(Stemp), inum, gibid_sectiondata[ix1][ix2]
		elseif (imode == 2) then
			tabw_i strtod(Stemp), inum, gibid_chordgroups[ix1][ix2]
		endif
		inum += 1
	od
	xout inum
endop


/*
	Read BID data for specified element and trigger accordingly.

	bid_seq Splayer, kposition, ksection

	Splayer		name of BID element
	kposition	position in pattern provided by master sequencer
	ksection	section in composition provided by master sequencer
	
*/
opcode bid_seq, 0, Skk
	Splayer, kpos, ksection xin
	Sinstrument = sprintf("play_%s", Splayer)
	instrindex = _bid_gettextindex(Splayer)
	kdata = gibid_sections[ksection][instrindex]

	if (kdata != -1) then ; null section
		kon = tablekt:k(kpos, gibid_sectiondata[kdata][0])
		
		if (kon == 1) then
			kchance = tablekt:k(kpos, gibid_sectiondata[kdata][3])
			if (random:k(0, 1) < kchance) then
				ktime = (kpos % 2 == 0) ? 0 : gibid_swingtime
				kdur = tablekt:k(kpos, gibid_sectiondata[kdata][1])
				;kamp = tablekt:k(kpos, gisectiondata[kdata][2])
				event "i", Sinstrument, ktime, kdur, kpos, kdata
			endif		
		endif
	endif
endop


/*
	Get a parameter for the specified pattern position.
	ipos and idataindex are provided as p4 and p5 to instruments scheduled by bid_seq,
	hence can typically used as bid_getparameter(p4, p5, iparameter)
	
	idata bid_getparameter ipos, idataindex, iparameter

	idata		the resulting value

	ipos		position in pattern
	idataindex	section specific data index; pointer to ftable
	iparameter	parameter index as in BID file; defaults include 0=on/off, 1=duration, 2=amp, 3=chance
	
*/
opcode bid_getparameter, i, iii
	ipos, idataindex, iparameter xin
	xout tab_i(ipos, gibid_sectiondata[idataindex][iparameter])
endop


/*
	Get a section length in beats

	klength bid_getsectionlength ksection

	klength		length in beats
	
	ksection	section to look up
*/
opcode bid_getsectionlength, k, k
	ksection xin
	xout tab:k(ksection, gibid_sectionlengths)
endop

/*
	Parse a row of comma-separated values to either section patterns or chord storage.
	Scans row, assigns ftable of appropriate length and then fills ftable.
	Internal use only.

	_bid_parserow Sline, ix1, ix2, imode

	Sline		line to parse
	ix1		array dimension 1 index of target storage
	ix2		array dimension 2 index of target storage
	imode		1=section patterns, 2=chords
*/
opcode _bid_parserow, 0, Siii
	Sline, ix1, ix2, imode xin
	isize = _bid_parserowitems(Sline, ix1, ix2, 0)
	if (imode == 1) then
		gibid_sectiondata[ix1][ix2] ftgen 0, 0, -isize, -7, 0
	elseif (imode == 2) then
		gibid_chordgroups[ix1][ix2] ftgen 0, 0, -isize, -7, 0
	endif
	isize = _bid_parserowitems(Sline, ix1, ix2, imode)
endop



/*
	Parse a line from a BID string
	Internal use only.

	idataout[] _bid_parseline Sline, idatain[]

	idataout[]	state data
	
	Sline		line to parse
	idatain[]	state data
	
*/
opcode _bid_parseline, i[], Si[]
	Sline, idata[] xin
	iparameter = idata[0]
	isection = idata[1]
	ichordnum = idata[2]
	isectiondataindex = idata[3]
	imode = idata[4]

	if (strlen(Sline) > 0) then
		Sfirstchar = strsub(Sline, 0, 1)

		; comment
		if (strcmp(Sfirstchar, ";") == 0) then 
			; no action

		; version check
		elseif (strcmp(Sfirstchar, "v") == 0) then 
			imode = 0
			iversion = strtod(strsub(Sline, 2))
			if (iversion != $BID_VERSION) then
				tt_notify(sprintf("Incompatible BID file version: got %.2f , expected %.2f", iversion, $BID_VERSION))
				exitnow
			endif

		; section header
		elseif (strcmp(Sfirstchar, "s") == 0) then 
			imode = 1
			icomma = strindex(Sline, ",")
			isectionnum = strtod(strsub(Sline, 2, icomma))
			Sub = strsub(Sline, icomma+1)
			icomma = strindex(Sub, ",")
			isectionlength = strtod(strsub(Sub, 0, icomma))
			ichordgroup = strtod(strsub(Sub, icomma+1))
			gibid_sectionchords[isectionnum] = ichordgroup
			tabw_i isectionlength, isectionnum, gibid_sectionlengths

		; tempo
		elseif (strcmp(Sfirstchar, "b") == 0) then 
			imode = -1
			icomma = strindex(Sline, ",")
			gibid_tempo = strtod(strsub(Sline, 2, icomma))
			gibid_beattime = 60 / gibid_tempo
			iswingpercent = strtod(strsub(Sline, icomma+1))
			gibid_swingtime = ((gibid_beattime/4)/100) * iswingpercent
			
		; chord group header
		elseif (strcmp(Sfirstchar, "c") == 0) then 
			imode = 3
			ichordgroup = strtod(strsub(Sline, 2))
			ichordnum = 0

		; pattern header
		elseif (strcmp(Sfirstchar, "i") == 0) then 
			imode = 4
			iparameter = 0
			
			icomma = strindex(Sline, ",")
			instrindex = _bid_gettextindex(strsub(Sline, 2, icomma), 1)
			Sub = strsub(Sline, icomma+1)
			icomma2 = strindex(Sub, ",")
			isection = strtod(strsub(Sub, 0, icomma2))
			if (isection > gibid_maxsection) then
				gibid_maxsection = isection
			endif
			if (icomma2 != -1) then ; repeat or null section
				irepeatsection = strtod(strsub(Sub, icomma2+1))
				if (irepeatsection == -1) then
					inewsection = -1
				else
					inewsection = gibid_sections[irepeatsection][instrindex]
				endif
				gibid_sections[isection][instrindex] = inewsection
			else
				isectiondataindex += 1
				gibid_sections[isection][instrindex] = isectiondataindex
			endif

		; chord row
		elseif (imode == 3) then
			_bid_parserow(Sline, ichordgroup, ichordnum, 2)
			ichordnum += 1

		; pattern row
		elseif (imode == 4) then
			_bid_parserow(Sline, isectiondataindex, iparameter, 1)
			iparameter += 1
		endif
	endif
	idata[0] = iparameter
	idata[1] = isection
	idata[2] = ichordnum
	idata[3] = isectiondataindex
	idata[4] = imode
	xout idata
endop


/*
	Parse a Bug Infested Directive Format string to global arrays, ftables and variables.
	Handles patterns, tempo, chord groups and sections etc accordingly.

	bid_loadtext Sfile, [imode = 0]

	Stext	directive data as string to parse
*/
opcode bid_loadtext, 0, S
	Stext xin
	idata[] fillarray -1, -1, -1, -1, -1
read:
	index = strindex(Stext, "\n")
	if (index != -1) then
		Sline = strsub(Stext, 0, index)
		Stext = strsub(Stext, index + 1)
		idata[] _bid_parseline Sline, idata

		igoto read
	else
		igoto complete
	endif
	
complete:
endop


/*
	Parse a Bug Infested Directive Format string to global arrays, ftables and variables.
	Handles patterns, tempo, chord groups and sections etc accordingly.
	Requires readfi support which is not available on all platforms. Platforms that do not support that
	should set NOFILEIO.

	bid_loadfile Sfile

	Sfile	directive file to parse
*/
opcode bid_loadfile, 0, S
	Sfile xin
#ifdef NOFILEIO
	tt_notify_fatal("Attempting to use parsefile when NOFILEIO is set")
#else	
	if (filevalid(Sfile) == 0) then
		tt_notify(sprintf("Directive file cannot be found: '%s'", Sfile))
		exitnow
	endif
	idata[] fillarray -1, -1, -1, -1, -1
read:
	Sline, ilinenum readfi Sfile
	Sline = tt_stripnewline(Sline)

	idata[] _bid_parseline Sline, idata

	if (ilinenum != -1) igoto read
#endif
endop



/*
	Set the current chord given a section
	p4	the section number
	p5	0=start at beginning, 1=increment chord index
*/
instr bid_setcurrentchord
	isection = p4
	ichordincrement = p5
	if (isection > gibid_maxsection) then
		turnoff
	endif

	ichordgroup = gibid_sectionchords[isection]
	if (ichordgroup != gibid_lastchordgroup || isection != gibid_lastsection) then
		gibid_currentchordnum = 0
		gibid_lastchordgroup = ichordgroup
		gibid_lastsection = isection
	elseif (ichordincrement == 1) then
		if (gibid_currentchordnum + 1 < lenarray(gibid_chordgroups, 2) - 1) then
			if (gibid_chordgroups[ichordgroup][gibid_currentchordnum + 1] == 0) then
				gibid_currentchordnum = 0
			else
				gibid_currentchordnum += 1
			endif
		else
			gibid_currentchordnum = 0
		endif
	else 
		gibid_currentchordnum = 0
	endif

	ifn = gibid_chordgroups[ichordgroup][gibid_currentchordnum]
	
	if (ifn > 0) then
		gkbid_chordlength = tab:k(0, ifn)
		gibid_chordfn = ifn
	endif

	if (timeinstk() > 2) then
		turnoff
	endif
endin


#end

