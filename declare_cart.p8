pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
#include speako8.p8
left,right,up,down,fire1,fire2=0,1,2,3,4,5
gpioaddress=0x5f80
printc=function(text,y,c)
	local length=print(text,0,-16)
	print(text,63-length\2,y,c)
end
function io()
	if (peek(gpioaddress)==0) then  --client requests permission to send new quote
		poke(gpioaddress,1)  --speako ready to receive new quote
		quote=""
		return
	end	
	if (peek(gpioaddress)==2) then  --client requests permission to send data block
		poke(gpioaddress,3)  --speako ready to receive data block
		return
	end	
	if peek(gpioaddress)==4 then  --client sent data block
		length=peek(gpioaddress+1)
		for i=2,length+2 do
			quote..=chr(peek(gpioaddress+i))
		end
		poke(gpioaddress,3)  --speako ready for more data
		return
	end	
	if peek(gpioaddress)==5 then  --client finished sending quote
		length=peek(gpioaddress+1)
		for i=2,length+2 do
			quote..=chr(peek(gpioaddress+i))
		end
		
		say(quote)
		poke(gpioaddress,1)  --speako ready for another quote
		return
	end	
end
gs_update=
{
	function() --say things
		speako8()
		if (not speaking()) _update=gs_update[2]
	end,
	function() --menu
		io()
		speako8()

		if (btnp(fire1) or btnp(fire2))then
		say(quote)

		_update=gs_update[1]
		elseif (btnp(left)) then
			mute()
			if (speech[selection]>minimum[selection]) speech[selection]-=delta[selection]
			speech[selection]=flr((speech[selection]+.005)*100)/100
			spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
			say'_/l/-1.40/3/ow/-1.37/-3/er'
		elseif (btnp(right)) then
			mute()
			if (speech[selection]<maximum[selection]) speech[selection]+=delta[selection]
			speech[selection]=flr((speech[selection]+.005)*100)/100
			spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
			say'_/hh/-1.16/3/ay/-1.37/3/er'
		elseif (btnp(up)) then 
			mute()
			selection-=1
			if (selection<1)selection=8
			say'_/-1.01/3/ah/-1.34/3/_/p'
		elseif (btnp(down))then
			mute()
			selection+=1
			if (selection>8)selection=1
			say'-1.69/-3/_/d/1.10/-3/aw/1.09/-3/n'
		end
	
	end,

}
gs_draw=
{
	function() -- say things
	end,
	function() -- menu
		cls()
		for i=1,#menu do
			
			if i==selection then
				printc("< "..menu[i]..": "..speech[i].." >",(i-1)*12+6,7)
			else
				printc(menu[i]..": "..speech[i],(i-1)*12+6,7)
			end	
		end
		printc("❎ play",119,7)	
	end

}

function _init()
	quote=""
	menu=split"pitch,rate,volume,quality,intonation,inherent f0,shift,whisper"
	selection=1
	speech={140,1,1,.5,10,10,1,1}
	delta={5,.05,.1,.01,1,1,.01,1}
	minimum={50,.01,.01,.01,0,0,.01,1}
	maximum={400,10,5,5,200,200,3,2}
	spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
	_update=gs_update[2]
	_draw=gs_draw[2]
	poke(gpioaddress,1) 
end

function _draw()
cls()

	line(0,64,127,64,7)
	for i=1,127 do
		line(i,127-peek(0x8000+i-1)/2,i,127-peek(0x8000+i)/2,8)
	end
--	print((phone_index+1).." "..phone_list[phone_index+1].."   "..words[phone_index+1],0,0,7)
end
