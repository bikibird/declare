pico-8 cartridge // http://www.pico-8.com
version 34
__lua__

w0=5512.5\200
voice_open=.3*w0
voice_b=-30/(voice_open*voice_open)
voice_a=-30/voice_open/3   ---voice_b*voice_open/3
voice_x=30
t=0
cls()
for i=0,127 do
	if t>=w0 then
		t=0
	else
		if t < voice_open then
			voice_b=-30/(voice_open*voice_open)
			voice_a=-30/voice_open/3   ---voice_b*voice_open/3
			--voice_x= 30 ---100*(w0-1)
		else
			voice_a += voice_b
			voice_x += voice_a
			--voice_x=20

		end
		t+=1
	end
	pset(i,64-voice_x,8)
end