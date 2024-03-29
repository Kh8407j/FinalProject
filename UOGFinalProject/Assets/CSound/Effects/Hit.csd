// KHOGDEN 001115381 bounds(0, 0, 0, 0)
<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")

button bounds(28, 38, 80, 40) channel("trigger")
hslider bounds(28, 94, 150, 23) channel("freq") range(0, 1000, 400, 1, 0.001)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1


instr 1
    kTrig chnget "trigger"
    if changed(kTrig) == 1 then
        event "i", "PlaySound", 0, .5
    endif

endin

instr PlaySound
    aEnv expon 1, p3, 0.001
    aSig oscili aEnv, chnget:i("freq")+(1-aEnv)*400
    outs aSig, aSig
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
