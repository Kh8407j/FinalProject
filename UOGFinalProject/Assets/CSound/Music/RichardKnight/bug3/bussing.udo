#ifndef UDO_BUSSING
#define UDO_BUSSING ##
/*
	Debugger - Unfixed Bugs : BUG #3

	Audio bussing
*/



/*
	Get the stereo L and R names for a singular bus name
	
	SnameL, SnameR bus_name Sbus

	SnameL		left bus identifier
	SnameR		right bus identifier

	Sbus		bus name
*/
opcode bus_name, SS, S
	Sbus xin
	xout sprintf("%sL", Sbus), sprintf("%sR", Sbus)
endop


/*
	Mix to a stereo bus

	bus_mix Sbus, aL, aR

	Sbus	bus name
	aL	left channel
	aR	right channel
*/
opcode bus_mix, 0, Saa
	Sbus, aL, aR xin
	SbusL, SbusR bus_name Sbus
	chnmix aL, SbusL
	chnmix aR, SbusR
endop



/*
	Read from a stereo bus, and then clear the bus
	
	aL, aR bus_read Sbus

	aL	left channel
	aR	right channel

	Sbus	bus name
*/
opcode bus_read, aa, S
	Sbus xin
	SbusL, SbusR bus_name Sbus
	aL chnget SbusL
	aR chnget SbusR
	chnclear SbusL
	chnclear SbusR
	xout aL, aR
endop




#end
