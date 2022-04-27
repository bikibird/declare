pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--Expands on https://www.lexaloffle.com/bbs/?uid=11031
--ðə beɪʒ hju ɑn ðə ˈwɔtərz əv ðə lɑk ɪmˈprɛst ɔl, ɪnˈkludɪŋ ðə frɛnʧ kwin bɪˈfɔr ʃi hɜrd ðət ˈsɪmfəni əˈgɛn ʤəst əz jʌŋ ˈɑrθər ˈwɑntəd
--The beige hue on the waters of the loch impressed all, including the French queen before she heard that symphony again just as young Arthur wanted
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
do
	t=0
	formant0=39	--5512.5/pitch
	buffer=0x8000
	words=split("odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two")

--data=split("aa,267,715,1100,715,1100,ae,278,660,1730,660,1730,ah,188,630,1200,630,1200,ao,283,570,840,570,840,aw,283,700,1520,440,1025,ay,250,750,1150,270,1900,eh,263,530,1850,530,1850,er,267,450,1380,450,1380,ey,192,480,700,400,1900,ih,243,400,2000,400,2000,iy,265,265,2290,265,2290,ow,282,540,1100,450,1100,oy,192,550,960,360,1820,uh,192,450,1100,500,1180,uw,237,350,1250,320,900")
--"ate hide toy"
data=split("ey,250,480,700,-.0001,.0002,ay,265,710,1100,-.0006,.0002,oy,192,550,960,-.0001,.0002")
	phone_reference={}

	phoneme={}
	local phoneme_count=#data\6-1
	for i=0,phoneme_count do
		local name=data[i*6+1]
		add(phone_reference,name)
		phoneme[name]={}
		phoneme[name][1]=data[i*6+2]*5.5125  --duration
		phoneme[name][2]=5512.5/data[i*6+3]  --f1 wavelength
		phoneme[name][3]=5512.5/data[i*6+4] --f2 wavelength
		phoneme[name][4]=data[i*6+5] --f1 step
		phoneme[name][5]=data[i*6+6] --f2 step
	end
	glottis=function(t,duration,f0,creak,hiss) -- w2 width of triangle
		if (f0==0) return rnd(hiss)-hiss/2
		local n0,w=t%f0,f0*(1-creak)
		return n0 < w and (w-abs(n0*2-w))/w*2  or rnd(hiss)-hiss/2
	end
	noise=function(t,duration,intensity)
		return rnd(intensity*2)-1
	end
	formant=function(t,duration,w1,delta)
		--if (t<duration/2) return cos(t/w1)
		return cos(t/(w1-delta*t))
		--if (t>2*duration/3) return cos(t/w2)
		--return cos(t/(w1+(w2-w1)*(t/duration)))
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
				{formant,phone[2],phone[4]}, --f1
				{formant,phone[3],phone[5]}, --f2
			}
		)
	end
	frequency=300
	function declare()
		if #voicing >0 then
			local length=voicing[1][1]
			while stat(108)<1536 do
				for i=0,511 do
				sample=1
					for j=2,4 do
						sample*=voicing[1][j][1](t,length,unpack(voicing[1][j],2))
					end
					
					sample=sample*64+128
					poke(buffer+i,sample)
					t += 1
					if  t>length then
						serial(0x808,buffer,i+1)
						deli(voicing,1)
						t=0
						return
					end
				--	sample=cos(t/(5512.5/frequency))*50+128
				--	poke(buffer+i,sample)
				--	t+=1
				end
				serial(0x808,buffer,512)	
			end
		end
	end
end
function keypress(key)
	if(key==13)input_waiting=true
	input_buffer..=key
end
function input()
	input_buffer=""
	input_waiting=false
end
function _init()
	poke(0x5F2D, 1)  --enable keyboard
	phone=1
	input()
end
function _update()
	while stat(30) do
		keypress(stat(31))
	end
	if input_waiting then
		synth(input_buffer,formant0,.2,.1)
		input()
	end
	if (btnp(up)) frequency+=100
	if (btnp(right)) then
		phone=(phone+1)%#phone_reference
		synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)

	end
	if btnp(left) then
		phone-=1
		if (phone<0)  phone=#phone_reference-1
		synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)
	end
	if (btnp(fire2)) synth(phoneme[phone_reference[phone+1]],formant0,.2,.1)
	declare()
end
function _draw()
	cls()
	print(phone_reference[phone+1],0,0)
	print(words[phone+1],0,10)
	--print(frequency,1,1)
	for i=0,256 do
	 y1=y2
	 y2=128-peek(buffer+i)/2
	 line((i-1)\2,y1,i\2,y2,8)
	 pset((i-1)\2,y1,6)
	 line(0,64,127,64,2)
	 
	end
	print(">"..input_buffer,120,0)
   end