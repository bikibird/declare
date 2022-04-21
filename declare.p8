pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--Expands on https://www.lexaloffle.com/bbs/?uid=11031
--ðə beɪʒ hju ɑn ðə ˈwɔtərz əv ðə lɑk ɪmˈprɛst ɔl, ɪnˈkludɪŋ ðə frɛnʧ kwin bɪˈfɔr ʃi hɜrd ðət ˈsɪmfəni əˈgɛn ʤəst əz jʌŋ ˈɑrθər ˈwɑntəd
--The beige hue on the waters of the loch impressed all, including the French queen before she heard that symphony again just as young Arthur wanted
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
do
	phone=0
	declare_volume=64
	declare_voice=50			--5512.5/pitch
	local n0, n1,n2=0
	local formant1,formant2,volume1,volume2,voice,delay,attack,sustain=0,0,0,0,0,0,0
	voice =40
	local play=false
	buffer=0x8000
	words=split("odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two")
	phonemes=split("aa,ae,ah,ao,aw,ay,eh,er,ey,ih,iy,ow,oy,uh,uw")
	duration=split("267,278,188,283,283,167,189,263,267,192,243,265,282,192,237")
	first_formant_from=split("768,660,623,652,650,750,580,474,450,427,342,450,450,469,378")
	first_formant_to=  split("768,660,623,652,500,500,580,474,400,427,342,469,400,469,378")
	second_formant_from=split("1333,1720,1200,997,1000,1150,1799,1379,700,2034,2322,1050,700,1122,997")
	second_formant_to=  split("1333,1720,1200,997,900,2000,1799,1379,1900,2034,2322,1122,1900,1122,997")

	for i=1,#phonemes do --convert to wavelengths
		--duration[i]=duration[i]*5.5125
		first_formant_from[i]=5512.5/first_formant_from[i]
		first_formant_to[i]=5512.5/first_formant_to[i]
		second_formant_from[i]=5512.5/second_formant_from[i]
		second_formant_to[i]=5512.5/second_formant_to[i]
	end
	
	waveform=
	{
		square=function (t, wavelength, width) --square
			return t>width and 1 or -1
		end,
		
		noise=function () --noise
			return rnd(2)-1
		end,

		saw=function(t,wavelength)
			return t%wavelength/wavelength*2-1 

		end,

		triangle=function(t,wavelength)

			return abs(t%wavelength-wavelength/2)/wavelength*2 -.5
		end,
		mountain=function(t,w1)
			local sample = abs(t%w1-w1/2)/w1*2 -.5
			return (sample <0 and 0 or sample)*2-.5
		end,
		glottis=function(t,f0,creak,hiss) -- w2 width of triangle
			if (f0==0) return rnd(hiss)-hiss/2
			local n0,w2=t%f0,f0*(1-creak)

			return n0 < w2 and (w2/2-abs(n0-w2/2))/w2*2  or rnd(hiss)-hiss/2
		end,
		breath=function(intensity)
			return rnd(intensity*2)-1
		end,
		vocal_tract=(t,w1,w2,duration)

		end



	}	
	envelope=
	{
		linear=function(t,duration)
			if (t<duration) return t/duration
			return 0
		end

	}
	function declare_phone(phone,s)
		-- voice: overall perceived pitch of voice
		-- power1, power2: relative amplitude of formants >=0, <1,  power1+power2==1  
		-- delay: glottal stop (inital silence) length in number of samples
		formant0=declare_voice
	--	formant1={first_formants_from[phone],first_formants_to[phone]} -- Wavelength of formant in number of samples.  11025 samples equals 2 seconds
	--	formant2={second_formants_from[phone],first_formants_to[phone]}
		volume1=v1 -- relative volume of formants v1 +v2 = 1
		volume2=v2
	--	delay=d -- glottal stop in number of samples.  	11025 samples equals 2 seconds
--		attack=a -- number of samples to reach full sustain value
		sustain=s -- maximum volume.  Ranges between zero and 127.
		length=duration[phone+1]*5.512-- how many samples to play
		n0,n1,n2=0,0,0
		l0,l1,l2=0,0,0
		t=0
		play=true
	end

	sound={}
	synth={}
	synth:new=function()
		o ={}  
		setmetatable(o, self)
		self.__index = self
		self.vocal=function() return 1 end
		self.noise=function() return 1 end
		return o
	end
	synth:vocalize=function(wave_function,...)
		self.vocal=function(t)
			return self.vocal(t)*wavefunction(t,...)
		end
		return self
	end
	synth:exhale=function(wave_function,...)
		self.noise=function(t)
			return self.noise(t)*wavefunction(t,...)
		end
		return self
	end
	synth:speak=function(t)
		return self.vocal(t)*self.noise(t)
	end
	
	function declare()
		if play then
			while stat(108)<1536 do
			
				for i=0,511 do
					local w1=(first_formant_from[phone+1]-first_formant_to[phone+1])*l0/length+first_formant_from[phone+1]
					local w2=(second_formant_from[phone+1]-second_formant_to[phone+1])*l0/length+second_formant_from[phone+1]
					--sample=flr(waveform.glottis(t,0,.1,.8)*cos(t/w1)*cos(t/w2)*sustain)+128
					sample=flr(waveform.glottis(t,formant0,.2,.8)*cos(t/w1)*cos(t/w2)*sustain)+128
					
					poke(buffer+i,sample)
					n0 +=1
					t += 1
					if  t>length then
						serial(0x808,buffer,i+1)
						play=false
						return
					end
				end
				serial(0x808,buffer,512)	
			end
			
		end
	end
end

function _update()
	if (btnp(right)) then
	--	declare_phone(phones[phonemes[phone+1]],64)
		phone=(phone+1)%#phonemes
		sound=cascade
		(
			bind(waveform.glottis,formant0,.2.8), 
			bind(cos,)
		)
		
	end
	if btnp(left) then
	--	declare_phone(phones[phonemes[phone+1]],64)
		phone=(phone-1)%#phonemes
		if (phone<0)  phone=0
		
	end
	if (btnp(fire2)) declare_phone(phone,64)
	declare()
end
function _draw()
	cls()
	print(phonemes[phone+1],0,0)
	print(words[phone+1],0,10)
	for i=0,256 do
	 y1=y2
	 y2=128-peek(buffer+i)/2
	 line((i-1)\2,y1,i\2,y2,8)
	 pset((i-1)\2,y1,6)
	 line(0,64,127,64,2)
	 
	end

   end