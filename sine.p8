pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
--Expands on
--sine
buffer=0x8000
wavelength=20
volume=32
t=0
function square(t, wavelength, width)
	return t>wavelength/2 and 1 or 0
end
function _update()
	while stat(108)<1536 do
		for i=0,511 do
			t=(t+1)%wavelength
			--sample=sin(t/wavelength)*volume+128
			sample=square(t,wavelength,10)*volume+128
			poke(buffer+i,sample)
		end
		serial(0x808,buffer,512)		
	end
end