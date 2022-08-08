See: https://home.cc.umanitoba.ca/~krussll/phonetics/acoustic/spectrogram-sounds.html

For a half-open tube that is 17 cm long (a typical length for an adult male's vocal tract), the preferred frequencies are 500 Hz, 1500 Hz, 2500 Hz, 3500 Hz, and so on.

# Vowels
- The frequency of the first formant is mostly determined by the height of the tongue body:
   - high F1 = low vowel (i.e., high frequency F1 = low tongue body)
   - low F1 = high vowel (i.e., low frequency F1 = high tongue body)
- The frequency of the second formant is mostly determined by the frontness/backness of the tongue body:
  - high F2 = front vowel
  - low F2 = back vowel
- For each vowel, F1 and F2 maintain a constant ratio between regardless of the overall pitch of the voice.
- [h] is really a voiceless version of the preceding or following vowel. On a spectrogram, it looks a little like a cross between a fricative and a vowel. It will have a lot of random noise that looks like static, but through the static you can usually see the faint bands of the voiceless vowel's formants.

# Fricatives
While each momentary burst of energy occurs at a random frequency, there are tendencies in which frequencies the random bursts cluster around. [s] has a higher average frequency than [ʃ] does; and both are higher than [f] or [θ].

# Plosives
The medial phase of a voiceless plosive is complete silence. On a spectrogram, this will appear as a white blank.

The quiet vocal fold vibrations in a voiced plosive will sometimes appear as a faint band along the bottom of the spectrogram at the frequency of f0. (But very often you won't see anything there, either because the voicing got lost in the background noise or because the recording or computer equipment cut off frequencies that low.)

To tell the difference between plosives, listeners rely on the release burst and on formant transitions. On a spectrogram, the release burst looks like a very, very thin fricative. The formant transitions (if you can see them) look like the formants have been distorted away from the frequencies they have during most of the vowel.

# Nasals and laterals

Nasals and [l] usually look like quite faint vowels, without a lot of amplitude in the higher frequencies.

You can still see some things that look like formants. But the acoustic properties of tubes with branches and side-chambers are much more complicated, with anti-formants as well as formants, so the formant bands will appear in different positions and usually be fainter. Which nasal or lateral it is usually isn't something you can figure out looking at just a spectrogram.

# CMU Pronouncing Dictionary

odd at hut ought cow hide be cheese dee thee Ed hurt ate fee green he it eat gee key lee me knee ping oat toy pee read sea she tea theta hood two vee we yield zee seizure


## F0
F0 simulates the glottal pulse train: http://msp.ucsd.edu/syllabi/170.13f/course-notes/node5.html#:~:text=When%20they%20open%2C%20a%20short,train%20with%20an%20audible%20pitch.

It is between 60 and 600 htz.  

men's modal F0 typically ranges between 80 and 175 Hz and women's between 160 and 270 Hz
5 year old child 220-320

## Production

Sample is set to zero every period of the wave.


## Parameters for each wave type

Wavelength: between 9 and 90. (5512.5/600 through 5512.5/60)
Pitch envelope: beginning pitch, ending pitch
Volume envelope: beginning volume, ending volume

5 bytes for each wave == 20 bytes for each sound + 1 byte duration.

duration: 1 through 255  corresponding to 8 through 370 miliseconds. Multiply by 8 to get miliseconds.

declare_phone(duration,f0_w0,f0_w1,f0_v0,f0_v1,f)

# Physical acoustics

-- Acoustic Phonetics, Chapter 1, table 1.1
Male:   throat 8.9 cm mouth 8.1 = 17 cm vocal tract 
Female: throat 6.3 cm mouth 7.8 = 14.1 cm vocal tract

--Listen lab antman video

For schwa sound:

F1 wavelength = 4 times vocal tract length.
F2 wavelenth = 4/3 times vocal tract length.

wavelength is speed of sound divided by frequency
frequency is speed of sound divided by wavelength

f1 frequency  for male: 34100/17/4 aproximately 500
f2 frequency for male:  f1*3 = 1500 because 3*34100/17/4


Diphthongs 
First 20% is starting vowel.  Then movement to ending volue

tense vowels are longer than lax vowels
Stressed syllables have higher F0, greater intensity, and longer duration than unstressed syllables.

A syllable has 3 parts: onset, nucleus, and coda


C   MAIN LOOP
    for duration
      if t%wavelength==0 then
        input=impuls
        inputs=sinamp
      else 
        input=0 
        inputs=0
      end
--     RESONATOR RGP:
      YGP=AGP*INPUT + BGP*YLGP1 + CGP*YLGP2
      YLGP2=YLGP1
       YLGP1=YGP
--     GLOTTAL ZERO PAIR RGZ:
      YGZ=AGZ*YGP + BGZ*YLGZ1 + CGZ*YLGZ2
       YLGZ2=YLGZ1
      YLGZ1=YGP
--     QUASI-SINUSOIDAL VOICING PRODUCED BY IMPULSE INTO RGP AND RGS:
        YGS=INPUTS*AGS + BGS*YLGS1 + CGS*YLGS2
        YLGS2=YLGS1
        YLGS1=YGS
        YGS=AGP*YGS + BGP*YLGS3 + CGP*YLGS4
        YLGS4=YLGS3
        YLGS3=YGS
--     GLOTTAL VOLUME VELOCITY IS THE SUM OF NORMAL AND QUASI-SINUSOIDAL VOICING
        UGLOT2=YGZ + YGS
--     RADIATION CHARACTERISTIC IS A ZERO AT THE ORIGIN
        UGLOT=UGLOT2-UGLOTX
        UGLOTX=UGLOT2
-- TURBULENCE NOISE OF ASPIRATION AND FRICATION GENERATE RANDOM NOISE, RANDOM PRODUCES UNIFORM DIST. (0. TO 1.)
370     NOISE=0.
C     MAKE PSEUDO-GAUSSIAN
        DO 371 NRANDX=1,16
371     NOISE=NOISE+rand(0)
C     SUBTRACT OFF DC
        NOISE=NOISE-8.
C     MODULATE NOISE DURING SECOND HALF OF A GLOTTAL PERIOD
375     IF (MPULSE.LE.0) NOISE=NOISE/2.
        MPULSE=MPULSE-1
C     LOW-PASS NOISE AT -6 DB/OCTAVE TO SIMULATE SOURCE IMPEDANCE
C     HIGH-PASS NOISE AT +6 DB/OCTAVE FOR RADIATION CHARACTERISTIC
C          (TWO EFFECTS CANCEL ONE ANOTHER)
C     GLOTTAL SOURCE VOLUME VELOCITY = VOICING+ASPIRATION
        AASPIR=AASPIR+DAHH
        UASP=AASPIR*NOISE 
380     UGLOT=UGLOT+UASP
C     SET FRICATION SOURCE VOLUME VELOCiTY
390     AFRIC=AFRIC+DAFF
C     PREPARE TO ADD IN A STEP EXCITATION OF VOCAL TRACT
C     IF PLOSIVE RELEASE (I.E. IF PLSTEP.GT.0.)
        IF (PLSTEP.LE.0.) GO TO 391
        STEP=-PLSTEP
        PLSTEP=0.
391     UFRIC=AFRIC*NOISE
C
C   SEND GLOTTAL SOURCE THRU CASCADE VOCAL TRACT RESONATORS
C     DO FORMANT EQUATIONS FOR NNXFC FORMANTS IN DESCENDING ORDER
C     TO MINIMIZE TRANSCIENTS
        IF (NXSW.EQ.1) GO TO 430
C     BYPASS R6 IF NNXFC LESS THAN 6
        Y6C=UGLOT
        IF (NNXFC.LT.6) GO TO 415
        Y6C=A6*UGLOT + B6*YL61C + C6*YL62C
        YL62C=YL61C
        YL61C=Y6C
C     BYPASS R5 IF NNXFC LESS THAN 5
415     Y5C=Y6C
        IF (NNXFC.LT.5) GO TO 416
        Y5C=A5*Y6C + B5*YL51C + C5*YL52C
        YL52C=YL51C
        YL51C=Y5C
416     Y4C=A4*Y5C + B4*YL41C + C4*YL42C
        YL42C=YL41C
        YL41C=Y4C
        Y3C=A3*Y4C + B3*YL31C + C3*YL32C
        YL32C=YL31C
        YL31C=Y3C
        Y2C=A2*Y3C + B2*YL21C + C2*YL22C
        YL22C=YL21C
        YL21C=Y2C
        Y1C=A1*Y2C + B1*YL11C + C1*YL12C
        YL12C=YL11C
        YL11C=Y1C
C     NASAL ZERO-PAIR RNZ:
420     YZC=ANZ*Y1C + BNZ*YLNZ1C + CNZ*YLNZ2C
        YLNZ2C=YLNZ1C
        YLNZ1C=Y1C
C     NASAL RESONATOR RNP:
        YPC=ANP*YZC + BNP*YLNP1C + CNP*YLNP2C
        YLNP2C=YLNP1C
        YLNP1C=YPC
        ULIPSV=YPC
C     ZERO OUT VOICING INPUT TO PARALEL BRANCH
C     IF CASCADE BRANCH HAS BEEN USED
425     UGLOT=0.
        UGLOTL=0.
C
C   SEND VOICING AND FRICATION NOISE THRU PARALLEL RESONATORS
C     INCREMENT RESONATOR AMPLITUDES GRADUALLY
430     CONTINUE
C     FIRST PARALLEL FORMANT R1' (EXCITED BY VOICING ONLY)
        Y1P=A1*A1PAR*UGLOT + B1*YL11P + C1*YL12P
        YL12P=YL11P
        YL11P=Y1P
C     NASAL POLE RN' (EXCITED BY FIRST DIFF. OF VOICING SOURCE)
        UGLOT1=UGLOT-UGLOTL
        UGLOTL=UGLOT
        IF (NXSW.NE.1) UGLOT1=0.
        YN=ANP*ANPAR*UGLOT1 + BNP*YLNP1 + CNP*YLNP2
        YLNP2=YLNP1
        YLNP1=YN
C     EXCITE FORMANTS R2'-R4' WITH FRIC NOISE PLUS FIRST-DIFF. VOICING
        Y2P=A2*A2PAR*(UFRIC+UGLOT1) + B2*YL21P +C2*YL22P
        YL22P=YL21P
        YL21P=Y2P
        Y3P=A3*A3PAR*(UFRIC+UGLOT1) + B3*YL31P +C3*YL32P
        YL32P=YL31P
        YL31P=Y3P
        Y4P=A4*A4PAR*(UFRIC+UGLOT1) + B4*YL41P +C4*YL42P
        YL42P=YL41P
        YL41P=Y4P
C     EXCITE FORMANT RESONATORS R5'-R6' WITH FRIC NOISE
        Y5P=A5*A5PAR*UFRIC + B5*YL51P +C5*YL52P
        YL52P=YL51P
        YL51P=Y5P
        Y6P=A6*A6PAR*UFRIC + B6*YL61P +C6*YL62P
        YL62P=YL61P
        YL61P=Y6P
C     ADD UP OUTPUTS FROM RN', R1' - R6' AND BYPASS PATH
        ULIPSF=Y1P-Y2P+Y3P-Y4P+Y5P-Y6P+YN-ABPAR*UFRIC
440     CONTINUE
C     ADD CASCADE AND PARALLEL VOCAL TRACT OUTPUTS
C     (SCALE BY 170 TO LEFT JUSTIFY IN 16-BIT WORD)
450     ULIPS=(ULIPSV+ULIPSF+STEP)*(170.)
        STEP=.995*STEP
C     FIND CUMULATIVE ABSOL. MAX. OF WAVEFORM SINCE BEGINNING OF UTT.
500     IF (ULIPS.GT.OUTMA) OUTMA=ULIPS
        IF (-ULIPS.GT.OUTMA) OUTMA=-ULIPS
C     TRUNCATE WAVEFORM SAMPLES TO ABS[WAVMA]
        IF (ULIPS.LE.WAVMA) GO TO 510
        ULIPS=WAVMA
510     IF (ULIPS.GE.WAVMAX) GO TO 520
        ULIPS=WAVMAX
520     IWAVE(NTIME)=ULIPS
530     CONTINUE --end duration lool
540     RETURN
        END

AV,AF,AH,AVS,F0,F1,F2,F3,FNZ,AN,A1,A2,A3
15 V A4
16 V A5
17 ¾ A6
18 V AB
19 V B1
20 V B2
21 V B3
22 C SW
23 C FGP
24 C BGP
25 C FGZ
26 C BGZ
27 C B4
28 V F5
29 C B5
30 C F6
31 C B6
32 C FN'P
33 C BN'P
34 C BNZ
35 C BGS
36 C SR
37 C NWS
38 C GO
39 C NFC
Amplitude of voicing (dB) 0 80 0
Amplitude of frication (dB) 0 80 0
Amplitude of aspiration (dB) 0 80 0
Amplitude of sinusoidal voicing (dB) 0 80 0
Fundamental freq. of voicing (Hz) 0 500 0
First formant frequency CHz) 150 900 450
Second formant frequency (Hz) 500 2500 1450
Third formant frequency (Hz) 1300 3500 2450
Fourth formant frequency (Hz) 2500 4500 3300
Nasal zero frequency (Hz) 200 700 250
Nasal formant amplitude (dB) 0 80 0
First formant amplitude (dB) 0 80 0
Second formant amplitude (dB) 0 80 0
Third formant amplitude (riB) 0 80 0
Fourth formant amplitude (riB) 0 80 0
Fifth formant amplitude (dB) 0 80 0
Sixth formant amplitude (dB) 0 80 0
Bypass path amplitude (dB) 0 80 0
First formant bandwidth (Hz) 40 500 50
Second formant bandwidth (Hz) 40 500 70
Third formant bandwidth (Hz) 40 500 110
Cascade/parallel switch 0(CASC) I(PARA) 0
Glottal resonator 1 frequency (Hz) 0 600 0
Glottal resonator I bandwidth (Hz) 100 2000 100
Glottal zero frequency (Hz) 0 5000 1500
Glottal zero bandwidth (Hz) 100 9000 6000
Fourth formant bandwidth (Hz) 100 500 250
Fifth formant frequency (Hz) 3500 4900 3750
Fifth formant bandwidth (Hz) 150 700 200
Sixth formant frequency (Hz) 4000 4999 4900
Sixth formant bandwidth (Hz) 200 2000 1000
Nasal pole frequency (Hz) 200 500 250
Nasal pole bandwidth (Hz) 50 500 100
Nasal zero bandwidth (Hz) 50 500 100
Glottal resonator 2 bandwidth 100 1000 200
Sampling rate 5000 20 000 10 000
Number of waveform samples per chunk 1 200 50
Overall gain control (dB) 0 80 47
Number of cascaded formants 4 6 5


Cascade
Formant frequency (F1, F2, F3, F4, F5, f6)
The "formant frequency" variables determine the frequency in Hz of up to six resonators of the cascade vocal tract model, and of the frequency in Hz of each of six additional parallel formant resonators. Normally, the cascade branch of 'nf'=5 formants is used to generate voiced and aspirated sounds, while the parallel branches are used to generate fricatives and plosive bursts.

Formant bandwidth (b1, b2, b3, b4, b5, b6)
The "formant bandwidth" variables determine the bandwidths of resonators in the cascade vocal tract model. Since formant bandwidths depend in part on source impedance, and turbulence sources contribute more losses, the synthesizer provides separate control of bandwidths 'p1' 'p2' 'p3' 'p4' 'p5' 'p6' for the parallel formants.

Nasal pole frequency (fp) and nasal zero frequency (fz)
The variable 'fp', "frequency nasal pole", in consort with the variable 'fz', "frequency nasal zero", can mimic the primary spectral effects of nasalization in vowel-like spectra. In a typical nasalized vowel, the first formant is split into peak-valley-peak (pole-zero-pole) such that 'fp' is at about 300 Hz, 'F1' is higher than it would be if the vowel were non-nasalized, and 'fz' is at a frequency approximately halfway between 'fp' and 'F1'. When returning to a non-nasalized vowel, 'fz' is moved down gradually to a frequency exactly the same as 'fp'. The nasal pole and nasal zero then cancel each other out, and it is as if they were not present in the cascade vocal tract model.

Nasal pole bandwidth (bp) and nasal zero bandwidth (bz)
The variables "bandwidth nasal pole," and "bandwidth nasal zero", are set to default values of 90 Hz. It is difficult to determine appropriate synthesis bandwidths for individual nasalized vowels, but, fortunately, one can achieve good synthesis results without changing these default values in most cases.

Parallel
Amplitudes of parallel formants (a1, a2, a3, a4, a5, a6, ab)
These variables determine the spectral shape of a fricative or plosive burst. The bypass path amplitude (ab) is used when the vocal tract resonance effects are negligible because the cavity in front of the main fricative constriction is too short, as in [f], [v], [θ], [ð], [p], [b].

Amplitude of frication (af)
Determines the level of frication noise sent to the various parallel formants and bypass path. The variable should be turned on gradually for fricatives (e.g. straight line from 0 to 60 dB in 90 msec), and abruptly to about 60 dB for plosive bursts.

Amplitude of aspiration (ah)
The amplitude in dB of the aspiration noise sound source that is combined with periodic voicing, if present ('av'>0), to constitute the glottal sound source that is sent to the cascade vocal tract. A value of zero turns off the aspiration source, while a value of 60 results in an output aspirated speech sound with levels in formants above F1 roughly equal to the levels obtained by setting 'av' to 60.

Amplitude of voicing (ap)
The amplitude, in dB, of voiced excitation of the parallel vocal tract. Normally, this would be allowed to remain at the default value of zero since the cascade vocal tract would be used for generating the voicing component of all voiced sounds (even voicebars and voiced fricatives).

Amplitude of nasal formant (an)
This variable is normally not used. However, when employing the parallel vocal tract to synthesize vowels, as discussed above, 'an' can be used to simulate the effects of nasalization on vowels and nasal murmurs.

Bandwidth of parallel formants (p1, p2, p3, p4, p5, p6)
These variables are set to default values that are wider than the bandwidths used in the cascade vocal tract model. It is difficult to measure formant bandwidths accurately in noise spectra, even when a fairly long sustained fricative is available for analysis. However, these default values can be used in most situations. The only adjustment is then made to the parallel formant amplitudes in order to match details in a natural frication spectrum.

av,ah,{{fa, fb},{fa, fb}}

Klatt's male-to-female transformation consisted in scaling F0 by a factor 1.7 and the formants by 1.175. He also
removed the fifth formant and increased the open quotient; both these things would
alter the spectral tilt. According to Klatt "These manipulations are not sufficient to
turn [the male voice) into a convincing female speaker" (Klatt, 1987, p. 784). 

The average F0 difference between men and women is about 0.9 octave, while the formant
bandwidths are only about 20% higher for women.

To get the source waveform in praat see https://www.fon.hum.uva.nl/praat/manual/Source-filter_synthesis_4__Using_existing_sounds.html

space pause 50 ticks, comma pause, 100 ticks.  period, !, ?, 200 ticks


additional resonator RNP
and anti-resonator RNZ into the cascade vocal tract
modelø The nasal pole frequency FNP can be set to a
fixed value of about 270 Hz for all time. The nasal zero
frequency FNZ should also be set to a value of about
270 Hz during non-nasalized sounds, but the frequency
of the nasal zero must be increased during the production of nasals and nasalization. T

The RNP-RNZ pair is
effectively removed from the cascade circuit during
the synthesis of non-nasalized speech sounds if FNP
= FNZ.

C     NASAL ZERO-PAIR RNZ:
420     YZC=ANZ*Y1C + BNZ*YLNZ1C + CNZ*YLNZ2C
        YLNZ2C=YLNZ1C
        YLNZ1C=Y1C
C     NASAL RESONATOR RNP:
        YPC=ANP*YZC + BNP*YLNP1C + CNP*YLNP2C
        YLNP2C=YLNP1C
        YLNP1C=YPC
        ULIPSV=YPC

Effects of stress level: When we examine the effects of
stress level in more detail, we find that primary and secondary
stressed vowels have significantly higher f0 than unstressed
vowels for both male and female speakers. For all data pooled,
there is no significant difference between secondary and
primary stressed vowels. If we analyse the speaker groups
separately, there is no difference for female speakers. For male
speakers the difference is significant. Furthermore, the
significant interaction between Stress and Sex can be
explained by the fact that the difference between unstressed
and stressed (i.e. primary and secondary stressed pooled) is
larger for the male speakers than for the female speakers; the
differences are 2 semitones and 1 semitone, respectively.

Stress level has a significant effect
on vowel duration and for this parameter all three levels are
significantly different. If we express the mean durations in
milliseconds, they are 53, 66, and 79 ms for unstressed,
secondary stressed and primary stressed vowels, respectively.
The significant effect of Sex is due to longer mean durations
for the female speakers. If we look at the speaker groups
separately we may see that the difference is almost entirely
caused by the markedly longer primary stressed vowels in the
female group (85 ms vs. 78 ms) which explains the significant
interaction between Stress and Sex.

https://archive.org/details/frontiersofspeec0000unse/page/292

F0 contour
a) gradual fall for a statement c) add locla pertubations for lexical stress and segmental factors. d)

Syntactic structure symbols are important determiners of sentence stress, rhythme, and intonation.  syntactic structure symbols appear just before the word boundary symbol.  Only one syntactic boundary symbol is always used.

Segmental duration:

The durational definitions adopted corrspond to the closure for a stop (any burst and aspiration at relase are assumed to be a part of the following segment)

Dur=((inherent_duration-minimum_duration)*prcnt)/100)+minimum_duration

mininum_duration if stressed. prcnt is set to 100 and rules update according to prcnt=prcnt*prcnt1

Set prcnt to 1

Split on commas and periods and insert 200ms pause before each clause. (Rule 1)

For each clause lengthen last vowel or syllabic consonsant prcnt*=1.4
(Rule 2)




