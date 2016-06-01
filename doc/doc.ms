.\" -*- coding: utf-8 -*-
.\" .nr PS 12
.EQ
delim $$
.EN
.NH
Design parameters
.LP
.TS
center allbox tab(;);
cb cb cb cb cb cb
l c c c c l.
parameter   ; min. ; typ. ; max.  ; unit ; comment
$f sub c$   ; 87.5 ;      ; 108.5 ; MHz  ; broadcast carrier frequency
$ Delta f$  ;      ;      ; 75    ; kHz  ; frequency deviation
$B$         ;      ; 210  ;       ; kHz  ; base-band bandwidth
$f sub m$   ; 0.03 ;      ; 15    ; kHz  ; modulation frequency
$f sub s$   ;      ; 240  ;       ; MHz  ; sampling frequency
$f sub b$   ;      ; 1    ;       ; MHz  ; base-band clock rate
$f sub DAC$ ; 32   ;      ; 48    ; kHz  ; output clock rate for DAC
$tau$       ;      ; 50   ;       ; µs   ; de-emphasis time constant (Europe)
.TE
.LP
The following constraints have to be fullfilled.
.EQ
f sub s mark > 2 cdot f sub c
.EN
.EQ
f sub s lineup > 2 cdot pi cdot f sub m
.EN
.EQ
f sub DAC lineup > 2 cdot f sub m
.EN
.EQ
B lineup > 2 ( Delta f + 2 cdot f sub m ) ~~~~roman "Carson's bandwidth rule"
.EN
.EQ
f sub b lineup > B
.EN
.NH
Theory of operation
.NH 2
Downsampling to I/Q base-band
.LP
The I/Q modulator works with 1-bit signals \*- for ADC input and for
the modulation signal.  The multiply operation is performed by a
simple XOR logic.
.LP
As a result, the base-band signal is a triangular wave instead of a
sine which will lead to harmonic distorsion.
.NH 2
Base-band filter
.LP
The base-band filter is composed of a cascaded integrator-comb (CIC)
filter. The first zero is $f sub c / M$ where $M$ is the decimation
factor of the CIC filter.  The base-band bandwith should be larger than
$B$.  For optimal channel separation $B$ should be less than 400\ kHz.
.NH 2
Downsampling to audio sample rate
.LP
A third order CIC decimator will convert from base-band sample rate to
audio sample rate.  This will effectively remove any frequencies above
15\~kHz, e.g. MPX and RDS signals.  Because no sinc-correction has
been made yet, the transfer function will drop at higher audio
frequencies.
.NH 2
De-emphasis
.LP
A de-emphasis filter with the transfer function
.EQ
H(s) = 1 over {1 + tau cdot s}
.EN
will correct the pre-emphased audio signal of the broadcast station.