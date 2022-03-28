pico-8 cartridge // http://www.pico-8.com
version 34
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
do
	local sample
	local n1,n2=0
	local formant1,formant2,volume1,volume2,voice,delay,attack,sustain=0,0,0,0,0,0,0,0
	local play=false
	local buffer=0x8000
	function declare_pitch(wavelength,volume)
		-- wavelength how many samples equal 1 wavelength  11025 samples equals 2 seconds
		-- volume = height of wave crest to trough
		while stat(108)<1536 do
			for i=0,511 do
				sample=sin(n/wavelength+.25)*volume + 128
				poke(buffer+i,sample)
				n +=1
				if (n>wavelength)n=0
			end
			serial(0x808,buffer,512)		
		end
		--declare_pitch(pitch,f1,f2,duration,volume,envelope)
		-- base pitch
		-- f1, f2 formant frequencies
		-- duration in number of samples to generate (11025 samples equals 2 seconds)
		-- envelope is a function that shapes the volume envelope
		--	envelope is given (pcm, Current sample #/duration 

	end
	function declare_phone(f1,f2,v1,v2,p,d,a,s)
		-- voice: overall perceived pitch of voice
		-- power1, power2: relative amplitude of formants >=0, <1,  power1+power2==1  
		-- delay: glottal stop (inital silence) length in number of samples
		formant1=f1 -- Wavelength of formant in number of samples.  11025 samples equals 2 seconds
		formant2=f2
		volume1=v1 -- relative volume of formants v1 +v2 = 1
		volume2=v2
		voice=p  -- What is this? frequency, pitch, something else?
		delay=d -- glottal stop in number of samples.  	11025 samples equals 2 seconds
		attack=a -- number of samples to reach full sustain value
		sustain=s -- maximum volume.  Ranges between zero and 127.
		n1,n2=0,0
		play=true
	end
	function declare()
		if play then
			while stat(108)<1536 do
				for i=0,511 do
					sample=(cos(n1/(formant1*voice))*volume1+cos(n2/(formant2*voice))*volume2)*sustain + 128
					poke(buffer+i,sample)
					n1 +=1
					n2 +=1
					if (n1>formant1)n1=0
					if (n2>formant2)n2=0
				end
				serial(0x808,buffer,512)		
			end
		end
	end

end
function _update()
	if (btnp(4)) declare_phone(13,3,.5,.5,.25,0,0,64)
	declare()
end