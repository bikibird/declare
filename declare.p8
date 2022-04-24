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
--phoneme, duration, aspiration onset ms, voice onset ms, attack ms, f1a, f1b, f2a, f2a,f3a,f3b
	data=split("aa,267,700,700,1220,1220,2600,2600,ae,278,620,650,1660,1490,2430,2470,ah,188,620,620,1220,1220,2550,2550,ao,283,600,630,990,1040,2570,2600,aw,167,640,420,1230,940,2550,2350,ay,189,660,400,1200,1880,2550,2500,eh,263,530,620,1680,1530,2500,2530,er,267,450,474,1379,1379,0,0,ey,192,480,330,1720,2020,2520,2600,ih,243,400,470,1800,1600,2570,2600,iy,265,310,290,2020,2070,2960,2960,ow,282,540,450,1100,900,2300,2300,oy,192,550,360,960,1820,2400,2450,uh,192,450,500,1100,1180,2350,2390,uw,237,350,320,1250,900,2200,2200")

	phone_reference={}
	phone=1
	phoneme={}
	local phoneme_count=#data\8-1
	for i=0,phoneme_count do
		local name=data[i*8+1]
		add(phone_reference,name)
		phoneme[name]={}
		phoneme[name][1]=data[i*8+2]*5.5125  --duration
		for j=3,6 do
			phoneme[name][j-1]=5512.5/data[i*8+j]
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
	formant=function(t,duration,w_from,w_to)
		return cos(t/w_from)
	end


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
				{formant,phone[6],phone[7]},
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
		phone=(phone+1)%#phone_reference
		synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)

	end
	if btnp(left) then
		phone-=1
		if (phone<0)  phone=#phone_reference-1
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