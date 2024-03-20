<CsoundSynthesizer>
<CsOptions>
-n -d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

instr 99

endin

<Cabbage>
form caption("SimpleFreq")
hslider channel("freq1"), text("Frequency Slider"), range(0, 10000, 0)
button channel("trigger"), text("Push me")
checkbox channel("mute")

instr PLAYER_MOVE
    kSpeed chnget "speed" //Gets the "speed" channel at k rate
    aNoise buzz 0.4, 100, 3, -1
    outs aNoise*kSpeed, aNoise*kSpeed 
endin
</Cabbage>

</CsInstruments>
<CsScore>
i99 0 10
</CsScore>
</CsoundSynthesizer>