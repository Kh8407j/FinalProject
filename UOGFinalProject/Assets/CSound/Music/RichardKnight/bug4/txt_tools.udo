#ifndef UDO_TXTTOOLS
#define UDO_TXTTOOLS ##
/*
	Debugger - Unfixed Bugs : BUG #4

	Text tools
*/


/*
	Print a notification prepended with a line of asterisks
	
	tt_notify Stext

	Stext	text to print
*/
opcode tt_notify, 0, S
	Stext xin
	Snew = "\n"
	iwidth = 60
	index = 0
	while (index < iwidth) do
		Snew = strcat(Snew, "*");
		index += 1
	od
	prints strcat(strcat(Snew, "\n"), strcat(Stext, "\n\n"))
endop



/*
	Print a notification prepended with a line of asterisks and exit
	
	tt_notify Stext

	Stext	text to print
*/
opcode tt_notify_fatal, 0, S
	Stext xin
	tt_notify(Stext)
	exitnow
endop


/*
	Return a number of seconds as HH:MM:SS format
	
	Stime tt_parsetime iseconds

	iseconds	seconds to parse
	
	Stime		formatted time

*/
opcode tt_parsetime, S, i
	input xin
	ihours = floor(input / 3600)
	iminutes = floor((input - (ihours * 3600)) / 60)
	iseconds = input - (ihours * 3600) - (iminutes * 60)
	xout sprintf("%02d:%02d:%05.2f", ihours, iminutes, iseconds)
endop


/*
	Strip newline from end of line: built-in opcode has some problems

	Soutput tt_stripnewline Sinput

	Soutput		processed without newline at end if existent
	
	Sinput		line to process
*/
opcode tt_stripnewline, S, S
	Sline xin
	index = strindex(Sline, "\n")
	if (index != -1) then
		Sline = strsub(Sline, 0, index)
	endif
	xout Sline
endop

#end
