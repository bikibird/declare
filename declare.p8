pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--Expands on https://www.lexaloffle.com/bbs/?uid=11031
--ðə beɪʒ hju ɑn ðə ˈwɔtərz əv ðə lɑk ɪmˈprɛst ɔl, ɪnˈkludɪŋ ðə frɛnʧ kwin bɪˈfɔr ʃi hɜrd ðət ˈsɪmfəni əˈgɛn ʤəst əz jʌŋ ˈɑrθər ˈwɑntəd
--The beige hue on the waters of the loch impressed all, including the French queen before she heard that symphony again just as young Arthur wanted
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
do
	index=0
	t=0
	declare_volume=64
	formant0=35	--5512.5/pitch
	local n0, n1,n2=0
	local formant1,formant2,volume1,volume2,voice,delay,attack,sustain=0,0,0,0,0,0,0
	voice =40
	local play=false
	buffer=0x8000
	words=split("odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two")

	data=split("aa,267,768,768,1333,1333,ae,278,620,650,1660,1490,ah,188,620,620,1220,1220,ao,283,600,630,990,1040,aw,167,750,500,1000,900,ay,189,580,500,1150,2000,eh,263,530,620,1680,1530,er,267,450,474,1379,1379,ey,192,427,400,700,1900,ih,243,400,470,1800,1600,iy,265,310,290,2020,2070,ow,282,450,469,1050,1122,oy,192,469,400,700,1900,uh,237,378,378,997,997")

	phone_reference=split("aa,ae,ah,ao,aw,ay,eh,er,ey,ih,iy,ow,oy,uh")
	phone=1
	phoneme={}
	local phoneme_count=#data\6-1
	for i=0,phoneme_count do
		local name=data[i*6+1]
		phoneme[name]={}
		phoneme[name][1]=data[i*6+2]*5.5125  --duration
		for j=3,6 do
			phoneme[name][j-1]=5512.5/data[i*6+j]
		end
	end


--[[	square=function (t, wavelength, width) --square
		return t>width and 1 or -1
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
	end,]]
	glottis=function(t,duration,f0,creak,hiss) -- w2 width of triangle
		--print(f0,80,0,8)
		--if (f0==0) return rnd(hiss)-hiss/2
		local n0,w2=t%f0,f0*(1-creak)
		return n0 < w2 and (w2-abs(n0*2-w2))/w2*2  or rnd(hiss)-hiss/2
	end
	noise=function(t,duration,intensity)
		return rnd(intensity*2)-1
	end
	--[[formant=function(t,duration,w_from,w_to)
		return cos(t/(w_from+(w_from-w_to)*t/duration))
	end]]
	formant=function(t,duration,w_from,w_to)
		return cos(t/w_from)
	end
	--[[function declare_phone(phone,s)
		formant0=declare_voice
		volume1=v1 -- relative volume of formants v1 +v2 = 1
		volume2=v2

		sustain=s -- maximum volume.  Ranges between zero and 127.
		length=duration[phone+1]*5.512-- how many samples to play
		n0,n1,n2=0,0,0
		l0,l1,l2=0,0,0
		t=0
		play=true
	end]]

	voicing={} 
	frication={} 

	function synth(phone,f0,creak,hiss)
		add
		(
			voicing,
			{	
				phone[1], --duration
				{glottis,f0,creak,hiss}, --formant 0 , creak, hiss
				{formant,phone[2],phone[3]},
				{formant,phone[4],phone[5]},
			}
		)
	end

	function declare()
		if #voicing >0 then
			local length=voicing[1][1]
			print(t,80,0,8)
			--local n0,w2=t%f0,f0*(1-.2)
			while stat(108)<1536 do
				for i=0,511 do
					sample=1
					for j=2,4 do
						sample*=voicing[1][j][1](t,length,unpack(voicing[1][j],2))
					end
		
					sample=sample*64+128
					poke(buffer+i,sample)
				--	n0 +=1
					t += 1
					if  t>length then
						serial(0x808,buffer,i+1)
						deli(voicing,1)
						t=0
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
		phone=(phone+1)%#phoneme
		synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)

	end
	if btnp(left) then
		phone=(phone-1)%#phoneme
		if (phone<0)  phone=0
		synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)
	end
	--if (btnp(fire2)) declare_phone(phone,64)
	declare()
end
function _draw()
	cls()
	print(phone_reference[phone+1],0,0)
	print(words[phone+1],0,10)
	for i=0,256 do
	 y1=y2
	 y2=128-peek(buffer+i)/2
	 line((i-1)\2,y1,i\2,y2,8)
	 pset((i-1)\2,y1,6)
	 line(0,64,127,64,2)
	 
	end

   end