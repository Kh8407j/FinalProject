/*
	Debugger - Unfixed Bugs : BUG #3

	Bug Infested Directives source
	Provided as a string due to readfi not being available on all platforms.
	Used with bid_loadtext (whereas a separate file would be used with bid_loadfile and requires readfi support)
*/

SBID = {{
; Bug Infested Directives : Debugger - Unfixed Bugs : BUG #3
v 1.0

; tempo, swing percent
b 125, 32

; chord groups
c 1
  8, 62, 65, 69, 72
  8, 61, 65, 68, 72, 67

c 2
  4, 69, 72, 77, 79
  4, 67, 70, 73, 77
  4, 65, 68, 73, 77
  4, 61, 65, 68, 72, 67


; sections: section number, length, chordgroup
s 1, 32, 1
s 2, 32, 1
s 3, 64, 1
s 4, 64, 1
s 5, 32, 1
s 6, 64, 1
s 7, 16, 2
s 8, 64, 1
s 9, 64, 1
s 10, 64, 2
s 11, 64, 2
s 12, 64, 2
s 13, 64, 2

; patterns: trig , dur, amp, chance

i hat909, 1
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0
  0, 0,.1, 0, 0, 0,.1, 0, 0, 0,.1,.1,.3, 0,.2,.1, 0, 0,.1, 0, 0, 0,.1, 0,.4, 0,.1, 0, 0, 0,.1, 0
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,.5,.4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.4, 0, 1, 0, 0, 0, 1, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i hat909, 2, 1
i hat909, 3, 1
i hat909, 4, 1
i hat909, 5, -1
i hat909, 6, -1
i hat909, 7, -1
i hat909, 8, 1
i hat909, 9, 1
i hat909, 10, 1
i hat909, 11
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0
  0, 0,.2, 0, 0, 0,.2, 0, 0, 0,.2,.1,.3, 0,.2,.1, 0, 0,.1, 0, 0, 0,.2, 0,.4, 0,.2, 0, 0, 0,.2, 0
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,.5,.4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.4, 0, 1, 0, 0, 0, 1, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i hat909, 12, 1
i hat909, 13
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0
  0, 0,.08, 0, 0, 0,.08, 0, 0, 0,.08,.1,.3, 0,.08,.1, 0, 0,.08, 0, 0, 0,.08, 0,.4, 0,.08, 0, 0, 0,.08, 0
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,.5,.4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.4, 0, 1, 0, 0, 0, 1, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

i 303, 1, -1
i 303, 2
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0,.2,.2,.3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.2,.2, 0, 0,.3, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0,.5,.6,.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.4,.5, 0, 0,.3, 0
i 303, 3
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0,.2,.2,.3, 0,.2,.2,.5, 0, 0,.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0,.5,.6,.8, 0,.7,.8,.6, 0, 0,.9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i 303, 4
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0
  0, 0, 0, 0, 0, 0,.2, 0, 0, 0, 0, 0, 0, 0,.4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.3, 0, 0, 0,.3, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1,.3, 1, 1, 1,.8, 1
  0, 0, 0, 0, 0, 0,.6, 0, 0, 0, 0, 0, 0, 0,.7, 0, 0, 0, 0, 0, 0, 0,.6, 0, 0, 0,.9, 0, 0, 0,.4, 0
i 303, 5
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0
  1, 0, 0, 0,.4, 0,.1, 0, 0, 0,.2,.2, 1, 0,.1, 0, 0, 0, 0, 0,.4, 0,.1, 0, 0, 0,.5, 0,.4, 0,.1, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.4, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1,.3, 1, 1, 1,.8, 1
 .5, 0, 0, 0,.5, 0,.2, 0, 0, 0,.8,.7,.5, 0,.3, 0, 0, 0, 0, 0, 0, 0,.3, 0, 0, 0,.3, 0,.5, 0,.7, 0
i 303, 6
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0
  0, 0, 0, 0, 0, 0,.4, 0, 0,.2,.3,.4, 0, 0,.4, 0, 0, 0, 0, 0, 0, 0,.3,.3, 0, 0,.3, 0, 0, 0,.5, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1,.3, 1, 1, 1,.8, 1
  0, 0, 0, 0, 0, 0,.4, 0, 0,.6,.7,.5, 0, 0,.4, 0, 0, 0, 0, 0, 0, 0,.4,.5, 0, 0,.2, 0, 0, 0,.3, 0
i 303, 7
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
 .2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.2,.4,.2
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1, 1, 1, 1, 1,.8, 1, 1, 1,.3, 1, 1, 1, 1, 1
 .1,.2,.3,.4,.5,.6,.7,.8,.9,.8,.7,.6,.5,.4,.3,.2,.1,.2,.3,.4,.5,.6,.7,.8,.9, 1,.9,.8,.7,.6,.8,.4
i 303, 8, 2
i 303, 9, 3
i 303, 10, 7
i 303, 11, 3
i 303, 12, 7
i 303, 13, 3


i mel1, 1, -1
i mel1, 2
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.3, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.7, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i mel1, 3
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0
  0, 0, 0,.1, 0, 0,.3, 0, 0, 0, 0,.1,.3, 0,.5,.1, 0, 0, 0,.2, 0, 0,.4, 0,.4, 0, 0, 0,.6, 0,.1, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1,.1, 1, 1, 1,.9, 1, 1,.7, 1,.2, 1, 1, 1,.5, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i mel1, 4, -1
i mel1, 5
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i mel1, 6, 2
i mel1, 7, -1
i mel1, 8, -1
i mel1, 9, -1
i mel1, 10, -1
i mel1, 11, -1
i mel1, 12, 3
i mel1, 13, 2


i hat909c, 1, -1
i hat909c, 2
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1
  .02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
 .6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6,.6
i hat909c, 3
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  .02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02,.02
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
 .8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8,.8
i hat909c, 4, -1
i hat909c, 5, -1
i hat909c, 6
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
  .02,.02,.02,.02,.02,.02,.02,.02,.2,.02,.02,.02,.02,.02,.1,.02,.02,.02,.02,.02,.02,.02,.5,.02,.02,.02,.02,.02,.02,.02,.02,.02
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i hat909c, 7, 3
i hat909c, 8, -1
i hat909c, 9, 2
i hat909c, 10, 2
i hat909c, 11, 3
i hat909c, 12, 2
i hat909c, 13, -1


; clap	trig , dur, amp, chance, lowpasson
i clap909, 1
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
  0, 0, 0, 0,.1, 0, 0, 0, 0, 0, 0, 0,.1, 0, 0,.1, 0,.1, 0, 0,.1, 0, 0, 0, 0, 0, 0, 0,.1, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.7, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i clap909, 2, 1
i clap909, 3, 1
i clap909, 4, 1
i clap909, 5
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
  0, 0, 0, 0,.1, 0, 0, 0, 0, 0, 0, 0,.1, 0, 0,.1, 0,.1, 0, 0,.1, 0, 0, 0, 0, 0, 0, 0,.1, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.7, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i clap909, 6, -1
i clap909, 7, -1
i clap909, 8, 1
i clap909, 9, 1
i clap909, 10, 1
i clap909, 11, 1
i clap909, 12, 1
i clap909, 13, 1


i rim, 1, -1
i rim, 2
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1
  0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6, 1,.4, 1, 1, 1, 1, 1, 1, 1, 1
i rim, 3, 2
i rim, 4, 2
i rim, 5, -1
i rim, 6
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
  0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.4, 1, 1, 1, 1, 1, 1, 1, 1
i rim, 7
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6, 1, 1, 1, 1, 1, 1, 1, 1
 .4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4
i rim, 8, 2
i rim, 9, 2
i rim, 10, -1
i rim, 11, -1
i rim, 12, 2
i rim, 13, 2

i kick, 1
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1
 .4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.3,.3
  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.6,.6
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6,.2
i kick, 2, 1
i kick, 3, 1
i kick, 4, 1
i kick, 5
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1
 .4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.3,.3
  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.6,.6
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.5, 1, 1, 1, 1, 1, 1, 1,.5, 1,.2,.1, 1, 1, 1, 1,.6,.2
i kick, 6, 1
i kick, 7
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
 .4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.4,.3,.3
  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0,.6,.6
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.6,.2
i kick, 8, 1
i kick, 9, 1
i kick, 10, 1
i kick, 11, 1
i kick, 12, 1
i kick, 13, 1

i bass, 1, -1
i bass, 2
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1
 .1,.1,.3,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.2,.1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.5, 1,.6,.5,.7
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i bass, 3, 2
i bass, 4
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1
 .1,.1,.3,.1,.1,.1,.5,.1,.1,.1,.1,.2,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.2,.1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,.5, 1,.6,.5,.7
  0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i bass, 5, -1
i bass, 6
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1
 .1,.1,.3,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.1,.2,.1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1,.7, 1, 1, 1,.5, 1, 1, 1, 1,.7, 1, 1, 1, 1, 1, 1,.7, 1, 1, 1, 1,.5, 1,.6,.5,.7
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i bass, 7
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
 .1,.1,.3,.1,.2,.1,.2,.1,.1,.1,.1,.1,.1,.2,.1,.2,.1,.1,.1,.1,.1,.1,.2,.2,.1,.1,.2,.2,.1,.1,.4,.1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i bass, 8, 2
i bass, 9, 4
i bass, 10, 2
i bass, 11, 7
i bass, 12, 2
i bass, 13, -1


i chord1, 1, -1
i chord1, 2, -1
i chord1, 3, -1
i chord1, 4
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  2, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i chord1, 5, -1
i chord1, 6, -1
i chord1, 7, -1
i chord1, 8, 4
i chord1, 9, 4
i chord1, 10
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
  2, 0, 0, 0, 0, 0, 0, 0, 0, 0,.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.5, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i chord1, 11, -1
i chord1, 12
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
  2, 0, 0, 0, 0, 0, 0, 0, 0, 0,.5,.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.5, 0, 0, 0,.5, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i chord1, 13, 12

i chord2, 1, -1
i chord2, 2, -1
i chord2, 3
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
i chord2, 4, 3
i chord2, 5
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
  0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0
i chord2, 6, -1
i chord2, 7, -1
i chord2, 8, -1
i chord2, 9, -1
i chord2, 10, -1
i chord2, 11
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
  0, 0,.5, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0,.5, 0, 0, 0, 0, 0, 0, 0
  1, 1,.3, 1, 1, 1, 1, 1, 1, 1,.3, 1, 1, 1, 1, 1, 1, 1,.3, 1, 1, 1, 1, 1,.3, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0
i chord2, 12, -1
i chord2, 13, -1

i chord3, 1, -1
i chord3, 2, -1
i chord3, 3
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,.2, 0, 0,.1, 0, 0,.2, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i chord3, 4, -1
i chord3, 5, -1
i chord3, 6, 3
i chord3, 7, -1
i chord3, 8, -1
i chord3, 9, 3
i chord3, 10
; 1  -  -  -  2  -  -  -  3  -  -  -  4  -  -  -  5  -  -  -  6  -  -  -  7  -  -  -  8  -  -  -
  1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
 .2, 0, 0,.1, 0, 0,.2, 0, 0, 0, 0, 0, 0, 0, 0, 0,.2, 0, 0,.1, 0, 0,.2, 0, 0, 0, 0, 0, 0, 0, 0, 0
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
i chord3, 11, 10
i chord3, 12, -1
i chord3, 13, -1
}}