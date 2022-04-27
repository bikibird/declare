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

# Declare

A unit of declare sound is composed of four waves, f0, f1, f2, and noise, lasting for a duration

## F0
F0 simulates the glottal pulse train: http://msp.ucsd.edu/syllabi/170.13f/course-notes/node5.html#:~:text=When%20they%20open%2C%20a%20short,train%20with%20an%20audible%20pitch.

It is between 60 and 600 htz.  

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

