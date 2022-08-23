pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--speako8 demo
--by bikibird
--loosely based on the klatt synthesizer
#include speako8.p8
left,right,up,down,fire1,fire2=0,1,2,3,4,5
printc=function(text,y,c)
	local length=print(text,0,-16)
	print(text,63-length\2,y,c)
	
end

gs_update=
{
	function() --say things
		speako8()
		if (not speaking()) _update=gs_update[2]
	end,
	function() --menu
		speako8()
		if (btnp(fire1) or btnp(fire2))then
		say'_/dh/-1.45/ah/-1.60/_/b/-1.25/3/ey/-1.06/zh/-1.22/hh/-1.29/y/-1.46/3/uw/-1.38/aa/-1.06/n/-1.12/dh/-1.45/ah/w/-1.41/3/ao/-1.69/_/t/-1.50/er/-1.06/z/-1.17/ah/-1.05/v/-1.12/dh/-1.45/ah/l/-1.30/3/aa/-1.68/_/k/-1.30/ih/-1.07/m/-1.67/_/p/-1.25/r/-1.26/3/eh/-1.27/s/-1.72/_/t/-1.28/ao/-1.16/l/_/-1.35/ih/-1.21/n/-1.71/_/k/-1.20/l/-1.35/3/uw/-1.69/_/d/-1.56/ih/-1.05/ng/-1.12/dh/-1.45/ah/-1.15/f/-1.25/r/-1.24/3/eh/-1.18/n/-1.69/_/ch/-1.71/_/k/-1.10/w/-1.40/3/iy/-1.14/n/_/-1.66/_/b/-1.67/ih/-1.07/f/-1.34/3/ao/-1.09/r/-1.18/sh/-1.25/iy/hh/-1.16/3/er/-1.69/_/d/-1.12/dh/-1.33/ae/-1.69/_/t/-1.18/s/-1.41/3/ih/-1.06/m/-1.20/f/-1.63/ah/-1.06/n/-1.56/iy/-1.62/ah/-1.68/_/g/-1.35/eh/-1.14/n/_/-1.69/_/jh/-1.25/ah/-1.27/s/-1.72/_/t/-1.10/ae/-1.06/z/-1.15/y/-1.23/3/ah/-1.05/ng/-1.39/3/aa/-1.25/r/-1.25/th/-1.55/er/w/-1.39/3/ao/-1.10/n/-1.72/-3/_/t/1.43/-3/ih/-1.64/-3/_/d'

		_update=gs_update[1]
		elseif (btnp(left)) then
			mute()
			if (speech[selection]>minimum[selection]) speech[selection]-=delta[selection]
			speech[selection]=flr((speech[selection]+.005)*100)/100
			quote,spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
			say'_/l/-1.40/3/ow/-1.37/-3/er'
		elseif (btnp(right)) then
			mute()
			if (speech[selection]<maximum[selection]) speech[selection]+=delta[selection]
			speech[selection]=flr((speech[selection]+.005)*100)/100
			quote,spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
			say'_/hh/-1.16/3/ay/-1.37/3/er'
		elseif (btnp(up)) then 
			mute()
			selection-=1
			if (selection<1)selection=9
			say'_/-1.01/3/ah/-1.34/3/_/p'
		elseif (btnp(down))then
			mute()
			selection+=1
			if (selection>9)selection=1
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
	
	quotes=split"hello world,marc antony,buggy bumpers,sea shells,daisy"
	menu=split"quote,pitch,rate,volume,quality,intonation,inherent f0,shift,whisper"
	selection=1
	speech={1,140,1,1,.5,10,10,1,1}
	delta={1,5,.05,.1,.01,1,1,.01,1}
	minimum={1,50,.01,.01,.01,0,0,.01,1}
	maximum={1,400,10,5,5,200,200,3,2}
	quote,spk8_pitch,spk8_rate,spk8_volume,spk8_quality,spk8_intonation,spk8_if0,spk8_shift,spk8_whisper=unpack(speech)
	
	say'_/hh/-1.58/ah/-1.07/l/-1.36/3/ow/-3/_/-1.03/-3/w/1.08/-3/er/1.65/-3/l/-1.64/-3/_/d/_/-1.11/3/ay/-1.02/m/-1.30/s/-1.64/_/p/-1.15/3/iy/-1.68/_/k/-1.13/3/ow/-1.46/3/ey/-1.71/_/t/_/-1.54/ah/-1.18/s/-1.64/_/p/-1.11/3/iy/-1.66/_/ch/-1.18/s/-1.41/3/ih/-1.18/n/-1.25/th/-1.62/ah/-1.09/s/-1.49/ah/-1.09/s/-1.15/l/-1.16/3/ay/-1.66/_/b/-1.25/r/-1.63/eh/-1.09/r/-1.45/iy/f/-1.26/ao/-1.09/r/-1.62/_/p/-1.27/3/iy/-1.68/_/k/-1.55/ow/-1.19/-3/ey/-1.64/-3/_/t/_/1.11/ay/-1.67/_/k/-1.18/ae/-1.06/n/-1.18/s/-1.22/3/ey/m/-1.19/ow/-1.27/s/-1.72/_/t/-1.18/3/eh/-1.06/n/-1.67/iy/-1.09/th/-1.46/ih/-1.05/ng/-1.15/y/-1.26/uw/-1.07/-3/l/-1.00/-3/ay/-1.65/-3/_/k'

	--say'_/-1.18/s/-1.64/_/p/-1.11/3/iy/-1.66/_/ch/-1.18/s/-1.41/3/ih/-1.18/n/-1.25/th/-1.60/ah/-1.09/-3/s/1.21/-3/ah/1.12/-3/s'



	_update=gs_update[2]
	_draw=gs_draw[2]
end


--[[function _update()
	speako8()
	if (btnp(right)) spk8_quality+=.05
	if (btnp(left)) spk8_quality-=.05	
	if (phone_index<0)	phone_index=#phone_list-1

	if (btnp(fire2)) then
		
		sounds={}


say'_/hh/-1.56/ah/-1.07/l/-1.36/3/ow/-3/_/-1.03/-3/w/1.08/-3/er/1.65/-3/l/-1.64/-3/_/d/_/-1.11/3/ay/-1.02/m/-1.30/s/-1.64/_/p/-1.15/3/iy/-1.68/_/k/-1.13/3/ow/-1.46/3/ey/-1.71/_/t/_/-1.52/ah/-1.18/s/-1.64/_/p/-1.11/3/iy/-1.66/_/ch/-1.18/s/-1.41/3/ih/-1.18/n/-1.25/th/-1.60/ah/-1.09/s/-1.47/ah/-1.09/s/-1.15/l/-1.16/3/ay/-1.66/_/b/-1.25/r/-1.63/eh/-1.09/r/-1.45/iy/f/-1.26/ao/-1.09/r/-1.62/_/p/-1.27/3/iy/-1.68/_/k/-1.55/ow/-1.19/-3/ey/-1.64/-3/_/t/_/1.11/ay/-1.67/_/k/-1.18/ae/-1.06/n/-1.18/s/-1.22/3/ey/m/-1.19/ow/-1.27/s/-1.72/_/t/-1.18/3/eh/-1.06/n/-1.67/iy/-1.09/th/-1.46/ih/-1.05/ng/-1.15/y/-1.26/uw/-1.07/-3/l/-1.00/-3/ay/-1.65/-3/_/k'

say'_/-1.15/f/-1.25/r/-1.35/3/eh/-1.11/n/-1.73/_/d/-1.24/z/_/-1.36/r/-1.48/3/ow/-1.02/m/-1.63/ah/-1.13/n/-1.24/z/_/-1.70/_/k/-1.13/3/ah/-1.21/n/-1.74/_/t/-1.25/r/-1.67/iy/-1.02/m/-1.67/ih/-1.14/n/_/-1.20/l/-1.31/3/eh/-1.11/n/-1.72/_/d/-1.04/m/-1.25/iy/y/-1.26/ao/-1.09/r/1.28/-3/ih/1.57/-3/r/1.09/-3/z/_/-1.10/ay/-1.67/_/k/-1.02/3/ah/-1.02/m/-1.71/_/t/-1.14/uw/-1.60/_/b/-1.35/3/eh/-1.09/r/-1.56/iy/s/-1.35/3/iy/-1.06/z/-1.63/er/_/-1.18/n/-1.37/3/aa/-1.69/_/t/-1.71/_/t/-1.14/uw/-1.62/_/p/-1.25/r/-1.18/3/ey/1.01/z/-1.30/-3/hh/1.28/-3/ih/1.03/-3/m'


	end	
end]]
function _draw()
cls()

	line(0,64,127,64,7)
	for i=1,127 do
		line(i,127-peek(0x8000+i-1)/2,i,127-peek(0x8000+i)/2,8)
	end
--	print((phone_index+1).." "..phone_list[phone_index+1].."   "..words[phone_index+1],0,0,7)
end
