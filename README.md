# Declare
Speech Synthesizer for PICO-8.

## Notes

See: https://home.cc.umanitoba.ca/~krussll/phonetics/acoustic/spectrogram-sounds.html

For a half-open tube that is 17 cm long (a typical length for an adult male's vocal tract), the preferred frequencies are 500 Hz, 1500 Hz, 2500 Hz, 3500 Hz, and so on.

### Vowels
- The frequency of the first formant is mostly determined by the height of the tongue body:
   - high F1 = low vowel (i.e., high frequency F1 = low tongue body)
   - low F1 = high vowel (i.e., low frequency F1 = high tongue body)
- The frequency of the second formant is mostly determined by the frontness/backness of the tongue body:
  - high F2 = front vowel
  - low F2 = back vowel
- For each vowel, F1 and F2 maintain a constant ratio between regardless of the overall pitch of the voice.
- [h] is really a voiceless version of the preceding or following vowel. On a spectrogram, it looks a little like a cross between a fricative and a vowel. It will have a lot of random noise that looks like static, but through the static you can usually see the faint bands of the voiceless vowel's formants.

### Fricatives
While each momentary burst of energy occurs at a random frequency, there are tendencies in which frequencies the random bursts cluster around. [s] has a higher average frequency than [ʃ] does; and both are higher than [f] or [θ].

### Plosives
The medial phase of a voiceless plosive is complete silence. On a spectrogram, this will appear as a white blank.

The quiet vocal fold vibrations in a voiced plosive will sometimes appear as a faint band along the bottom of the spectrogram at the frequency of f0. (But very often you won't see anything there, either because the voicing got lost in the background noise or because the recording or computer equipment cut off frequencies that low.)

To tell the difference between plosives, listeners rely on the release burst and on formant transitions. On a spectrogram, the release burst looks like a very, very thin fricative. The formant transitions (if you can see them) look like the formants have been distorted away from the frequencies they have during most of the vowel.

### Nasals and laterals

Nasals and [l] usually look like quite faint vowels, without a lot of amplitude in the higher frequencies.

You can still see some things that look like formants. But the acoustic properties of tubes with branches and side-chambers are much more complicated, with anti-formants as well as formants, so the formant bands will appear in different positions and usually be fainter. Which nasal or lateral it is usually isn't something you can figure out looking at just a spectrogram.
