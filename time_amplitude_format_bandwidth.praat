outPath$ = "C:\Users\Jenny\Documents\github\bikibird\declare\"
phone$ = "how_are_you"

inFile$ = outPath$ + phone$ + ".wav"
outFile$ = outPath$ + phone$ + "_ANALYSIS.txt"

# header
writeFileLine: outFile$, "time, amplitude, pitch, formant1, formant2, formant3, formant4, bandwidth1, bandwidth2, bandwidth3, bandwidth4"

# read the file
sound = Read from file: inFile$

# select the object
selectObject: sound

# sampling range - range in ms
start = 0
finish = Get total duration
stepSize = 0.01


# open the editor
View & Edit
editor: "Sound " + phone$
    # loop through the range
    at = start
    while at < finish
        # position cursor
        Move cursor to: at
        
        # get the values
        amp = Get intensity
	amp = 10^(amp/20)
        pitch = Get pitch

        f1 = Get first formant
        f2 = Get second formant
        f3 = Get third formant
        f4 = Get fourth formant

        bw1 = Get first bandwidth
        bw2 = Get second bandwidth
        bw3 = Get third bandwidth
        bw4 = Get fourth bandwidth

        # convert "--undefined--" to -1
        if string$(amp) = "--undefined--"
            amp = -1
        endif

        if string$(pitch) = "--undefined--"
            pitch = -1
        endif


        if string$(f1) = "--undefined--"
            f1 = -1
        endif

        if string$(f2) = "--undefined--"
            f2 = -1
        endif

        if string$(f3) = "--undefined--" 
            f3 = -1
        endif

        if string$(f4) = "--undefined--"
            f4 = -1
        endif

        if string$(bw1) = "--undefined--"
            bw1 = -1
        endif

        if string$(bw2) = "--undefined--"
            bw2 = -1
        endif

        if string$(bw3) = "--undefined--"
            bw3 = -1
        endif

        if string$(bw4) = "--undefined--"
            bw4 = -1
        endif



        # write the values to the file
        appendFileLine: outFile$, 
            ...string$(at) + ", " 
            ...+ string$(amp) + ", " 
            ...+ string$(pitch) + ", " 
            ...+ string$(f1) + ", " 
            ...+ string$(f2) + ", " 
            ...+ string$(f3) + ", " 
            ...+ string$(f4) + ", " 
            ...+ string$(bw1) + ", " 
            ...+ string$(bw2) + ", " 
            ...+ string$(bw3) + ", " 
            ...+ string$(bw4)

        # move ahead
        at = at + stepSize
    endwhile
endeditor

# close the object
removeObject: sound