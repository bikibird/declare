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
	formant0= 2.75	--5512.5/pitch
	buffer=0x8000
	words=split("odd,at,hut,ought,cow,hide,ed,hurt,ate,it,eat,oat,toy,hood,two")

formant_data=split("aa,715,1100,715,1100,ae,660,1730,660,1730,ah,630,1200,630,1200,ao,570,840,570,840,aw,700,1520,440,1025,ay,660,1730,265,2300,eh,530,1850,530,1850,er,450,1380,450,1380,ey,715,1200,265,2300,ih,400,2000,400,2000,iy,265,2290,265,2290,ow,540,1100,450,1100,oy,560,835,265,2300,uh,450,1100,500,1180,uw,350,1250,320,900")

envelop_data=split("aa,267,ae,278,ah,188,ao,283,aw,283,ay,200,eh,263,er,267,ey,200,ih,243,iy,265,ow,282,oy,200,uh,192,uw,237")
	phone_reference={}

	f1,f2,envelop={},{},{}
	local phone_count=#formant_data\5-1
	for i=0,phone_count do
		local name=formant_data[i*5+1]
		add(phone_reference,name)

		f1[name],f2[name]={},{}

		--f1_f2[name][1]=formant_data[i*6+2]*5.5125  --duration
		f1[name][1]=5512.5/formant_data[i*5+2]  --f1 wavelength
		f2[name][1]=5512.5/formant_data[i*5+3] --f2 wavelength
		f1[name][2]=(5512.5/formant_data[i*5+4]-f1[name][1])/1380 --f1 step  1380= .25seconds*5512
		f2[name][2]=(5512.5/formant_data[i*5+5]-f2[name][1])/1380 --f2 step
	end
--[[	function vibrate(t,x,s) -- f0 width of triangle
		s.d-=1
		
		if (s.w==0) return rnd(s.hiss*2)-s.hiss
		local n0,w=t%s.w,s.w*(1-s.creak)
		--return n0 <= w and ((w-abs(n0*2-w))/w) or rnd(hiss*2)-hiss
		s.x2=s.x1
		s.x0=n0 <= w and -sin(n0/(w*2)) or rnd(s.hiss*2)-s.hiss
		return s.x0
	end
]]
function noise(t,duration,intensity)
	return rnd(intensity*2)-intensity
end
function resonate(t,duration,w1,delta)
	if (delta==0) return cos(t/w1)
	return cos(t/(w1+delta*(t\55*55)/duration)) --55 aprox 10 milliseconds
end
function slope(t,duration,a,b)
	return a+(b-a)*t/duration
end

	function vibrate(t,x,s)	
		s.d-=1
		return t%(s.w)==0 and 1 or 0
	end

	function formant(t,x,s)
		s.y2=s.y1
		s.y1=s.y0
		s.y0=s.a*x + s.b*s.y1 + s.c*s.y2
		s.d-=1
		return s.y0*4
	end
	function antiformant(t,x,s)
		local y0=s.a*x + s.b*s.x1 + s.c*s.x2
	--	s.x2=s.x1
	--	s.x1=s.x0
	--	s.x0=y0
		s.y2=s.y1
		s.y1=y0
	--	s.y0=y0
		s.d-=1
		return y0
	end
	function silence(t,x,s)
		s.d-=1
		return 0
	end
	voicing={} 
	frication={} 
	function synth(phoneme,f0,creak,hiss)

		add
		(
			voicing,
			{	
				{filter=vibrate,d=1000,creak=.2, hiss=.1,w=5512.5\140,},
				{filter=formant,d=1000,a=0.0030688064,b=1.889206383,c=-0.8922751893,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-0}, --normal voice
				{filter=formant,d=1000,a=0.1210683955,b=1.828933491,c=-0.9500018865,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-0}, --f1
				{filter=formant,d=1000,a=2.988361593,b=-1.19220658,c=-0.7961550134,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-00}, --f2
			}
		)
		add 
		(
			voicing,
			{
				{filter=silence,d=5000,creak=.2, hiss=.1,w=5512.5\140,},
		
			}
		)	
		add
		(
			voicing,
			{	
				{filter=vibrate,d=1000,creak=.2, hiss=.1,w=5512.5\140,},
				{filter=formant,d=1000,a=0.0030688064,b=1.889206383,c=-0.8922751893,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-0}, --normal voice
				{filter=formant,d=1000,a=0.4617551681,b=1.461558303,c=-0.9233134711,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-0}, --f1
				{filter=formant,d=1000,a=2.422667792,b=-0.5798218008,c=-0.8428459914,x0=0,x1=0,x2=0,y0=-0,y1=-0,y2=-00}, --f2
			}
		)
	end
	function declare()
		if #voicing >0 then
			while stat(108)<1536 do
				for i=0,511 do
				sample=0
					for j=1,#voicing[1] do
						local dsp=voicing[1][j]
						sample=dsp.filter(t,sample,dsp)
					end
					sample=sample*64+64
					poke(buffer+i,sample)
					t += 1
					if (voicing[1][1].d==0)then
						serial(0x808,buffer,i+1)
						deli(voicing,1)
						t=0
						return
					end
				end
				serial(0x808,buffer,512)	
			end
		else
			t=0	
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
	phone_index=1
	phoneme=phone_reference[phone_index+1]
	t=0
	input()

	
	--poke(buffer,128)
	--serial(0x808,buffer,1)	
end
function _update()
	while stat(30) do
		keypress(stat(31))
	end
	if input_waiting then
		synth(input_buffer,formant0,.2,.2)
		input()
	end
--	if (btnp(up)) phone[phoneme][5]+=0x0.0001
--	if (btnp(down)) phone[phoneme][5]-=0x0.0001

	if (btnp(right)) then
		phone_index=(phone_index+1)%#phone_reference
		phoneme=phone_reference[phone_index+1]
		synth(phoneme,formant0,.2,.01)

	end
	if btnp(left) then
		phone_index-=1
		if (phone_index <0)  phone_index=#phone_reference-1
		phoneme=phone_reference[phone_index+1]
		synth(phoneme,formant0,.2,.1)
	end
	if (btnp(fire2)) then
		t=0
		synth(phoneme,formant0,.2,.01)
	end	
	declare()
end
function _draw()
	cls()
	print(phoneme,0,0)
	print(words[phone_index+1],0,10)
	
	
	--print(frequency,1,1)
	for i=0,256 do
	 y1=y2
	 y2=128-peek(buffer+i)/2
	 line((i-1)\2,y1,i\2,y2,8)
	 pset((i-1)\2,y1,6)
	 line(0,64,127,64,2)
	end
	print(t,80,10,7)
   end