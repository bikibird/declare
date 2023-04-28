pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
do

	--poke(0x5f36,@0x5f36^^0x20) --turn off pcm channel dampening

	--=duration,source (frication=0 aspriation=1 voicing=2 silence=3),volume,velocity,slide,frication,inherent f0, f3, f3:bandwith,f2,f2:bw,f1,f1:bw,nasal frequency, nasal bandwidth
	
	
	data=split("aa=1320,2,89,0,4,2,1,2600,160,1220,70,700,130,270,100;ae=630,2,89,0,4,2,.79,2430,300,1660,130,620,70,270,100/630,2,100,0,4,2,.79,2470,300,1490,130,650,70,270,100;ah=770,2,96,0,4,2,.79,2550,140,1220,50,620,80,270,100;ao=1320,2,93,0,4,2,.74,2570,80,990,100,600,90,270,100;aw=715,2,89,0,4,2,.79,2550,110,1230,70,640,80,270,100/715,2,89,0,4,2,0,2350,110,940,70,420,80,270,100;ay=685,2,93,0,4,2,.9,2550,200,1200,120,660,100,270,100/685,2,93,0,4,2,.223,2500,200,1880,120,400,100,270,100;eh=410,2,104,0,4,2,.44,2500,200,1680,90,530,60,270,100/410,2,104,0,4,2,.44,2530,200,1530,90,620,60,270,100;rr=495,2,108,0,4,2,.41,1540,110,1270,60,470,100,270,100/495,2,108,0,4,2,.41,1700,140,1500,80,450,60,270,100;ar=715,2,100,0,4,2,1,2380,110,1170,60,680,60,270,100/715,2,100,0,4,2,.41,1650,110,1400,60,520,60,270,100;er=740,2,100,0,4,2,.44,2400,140,1650,80,460,60,270,100/740,2,100,0,4,2,.41,1700,140,1500,80,450,60,270,100;ir=630,2,100,0,4,2,.23,2900,120,1900,80,320,70,270,100/630,2,100,0,4,2,.41,1750,120,1550,80,420,70,270,100;or=660,2,100,0,4,2,.74,2200,60,820,60,550,60,270,100/660,2,100,0,4,2,.41,1500,60,1300,60,490,60,270,100;ur=630,2,100,0,4,2,.36,2000,80,800,60,360,60,270,100/630,2,100,0,4,2,.41,1500,80,1150,60,390,60,270,100;ey=520,2,96,0,4,2,.44,2520,200,1720,100,480,70,270,100/520,2,96,0,4,2,.05,2600,200,2200,100,330,70,270,100;ih=370,2,100,0,4,2,.23,2670,140,1800,100,400,50,270,100/370,2,100,0,4,2,.23,2670,140,1800,100,400,50,270,100;iy=425,2,100,0,4,2,0,2960,400,2200,200,310,50,270,100/425,2,100,0,4,2,0,2980,400,2070,200,290,50,270,100;ow=575,2,100,0,4,2,.59,2300,70,1100,70,540,80,270,100/575,2,100,0,4,2,.59,2300,70,900,70,450,80,270,100;oy=513,2,108,4,0,2,.62,2400,160,960,120,550,80,270,100/513,2,108,0,4,2,.13,2450,160,1820,120,360,160,270,100/513,2,108,0,4,2,.13,2400,130,1820,50,360,80,270,100;uh=220,2,112,0,4,2,.36,2350,80,1100,100,450,80,270,100/220,2,112,0,4,2,.36,2390,80,1180,100,500,80,270,100;uw=575,2,117,0,4,2,.1,2200,140,1250,110,350,70,270,100/575,2,117,0,4,2,-.12,2200,140,900,110,320,70,270,100;l=440,2,68,0,4,2,0,2800,280,1050,100,330,50,270,100;lx=490,2,100,0,4,2,0,2850,70,800,60,450,80,270,100;el=1430,2,89,0,4,2,.79,2850,80,800,60,450,70,270,100;r=440,2,89,0,1,2,0,1560,70,1260,60,460,60,270,100;em=465,2,68,0,4,2,.79,2100,70,900,60,200,120,270,100/465,2,100,0,4,2,0,2150,200,1100,150,400,300,450,100;m=380,2,71,0,0,0,0,2150,200,1100,150,400,300,450,100;en=465,2,68,0,4,2,.79,2700,260,1400,300,480,40,270,100/465,2,100,0,4,2,0,2600,170,1600,100,200,60,450,100;n=330,2,71,0,0,0,0,2600,170,1600,100,200,60,450,100;ng=520,2,71,0,0,0,0,2050,100,1690,150,480,100,450,160;ch=380,2,0,0,0,0,0,2400,270,1700,110,300,200,270,100;chx=80,0,0,10,0,0,0,2400,270,1700,110,300,200,270,100;sh=570,0,0,6,0,0,0,2400,280,1650,110,400,200,270,100;zh=380,0,0,10,0,0,0,2400,250,1650,140,300,220,270,100;jh=380,2,0,0,0,0,0,2400,270,1700,110,200,50,270,100;jhx=55,2,79,30,0,0,0,0,2400,270,1700,110,200,50,270,100;dh=270,2,40,5,0,0,0,2700,190,1150,100,300,60,270,100;f=550,0,0,6,0,0,0,2100,180,1130,120,400,230,270,100;s=570,0,0,6,0,0,0,2700,220,1400,100,400,200,270,100;k=440,2,0,0,0,0,0,1900,280,1600,220,350,250,270,100;kx=140,0,0,10,0,0,0,1900,280,1600,220,350,250,270,100;p=490,2,0,0,0,0,0,2150,220,1100,150,400,300,270,100;px=44,0,0,10,0,0,0,2150,220,1100,150,400,300,270,100;t=410,2,0,0,0,0,0,2700,220,1400,180,300,300,270,100;tx=80,0,0,15,0,0,0,2700,220,1400,180,300,300,270,100;g=440,2,0,0,0,0,0,1900,190,1600,150,250,70,270,100;gx=110,2,79,0,0,0,0,1900,190,1600,150,250,70,270,100;b=460,2,0,0,0,0,0,2100,130,900,90,200,70,270,100;bx=30,2,79,0,0,0,0,2100,130,900,90,200,70,270,100;d=380,2,0,0,0,0,0,2700,180,1400,120,200,70,270,100;dx=55,2,79,0,0,0,0,2700,180,1400,120,200,70,270,100;dd=110,2,0,0,0,0,0,2700,250,1600,140,200,120,270,100;ddx=55,2,100,0,0,0,0,2700,250,1600,140,200,120,270,100;th=490,0,0,6,0,0,0,2700,200,1150,100,400,230,270,100;v=330,2,46,10,0,0,0,2100,130,1130,100,300,60,270,100;z=410,2,46,10,0,0,0,2700,190,1400,90,300,70,270,100;w=440,2,89,0,0,2,0,2150,60,610,80,290,50,270,100;y=440,2,89,0,0,2,0,3020,500,2070,250,240,40,270,100;hh=440,0,0,0,0,0,0,0,0,0,0,0,0,270,100;_=550,2,0,0,0,0,0,2500,120,1500,60,430,120,270,100/550,2,0,0,0,0,0,2500,120,1500,60,430,120,270,100",";")
--=duration,source (frication=0 aspriation=1 voicing=2 silence=3),volume,frication,velocity,slide,inherent f0, f3, f3:bandwith,f2,f2:bw,f1,f1:bw,nasal frequency, nasal bandwidth
	

	phone={}
	for phoneme in all(data) do
		local p=split(phoneme,"=")
		local key,frames=p[1],split(p[2],"/")
		phone[key]={}
		for f in all(frames) do
			local frame_data=split(f)
			local frame={unpack(frame_data,1,7)}
			frame[8]={}
			for i=8,14,2 do
				add(frame[8],{unpack(frame_data,i,i+1)})
			end
			add(phone[key],frame)
		end
	end
	local f0,w0,nasalize,yzc,ylnz1c,ylnz2c,ylnp1c,ylnp2c,sample,x0,noise,t,duration,counter,velocity,v,buffer,b100,c100,acceleration,f_step,bw_step,source,delta_f0,y0,y1,y2,p0,p1,p2,frication,pitch,cascade,cascade2,formants,open,b1,amplitude,v_stress=unpack(split"140,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0x8000,0x1.233b,-0x.52d4")
	sounds={}
	 
	-- b coefficient first factor = =2*exp(-pi()*bandwidth/5512.5)  
	b_factor=split"2,0x1.fd17,0x1.fa32,0x1.f752,0x1.f475,0x1.f19d,0x1.eec9,0x1.ebfa,0x1.e92e,0x1.e666,0x1.e3a3,0x1.e0e3,0x1.de27,0x1.db70,0x1.d8bc,0x1.d60c,0x1.d360,0x1.d0b9,0x1.ce14,0x1.cb74,0x1.c8d8,0x1.c63f,0x1.c3aa,0x1.c119,0x1.be8c,0x1.bc02,0x1.b97c,0x1.b6fa,0x1.b47b,0x1.b200,0x1.af89,0x1.ad15,0x1.aaa5,0x1.a838,0x1.a5cf,0x1.a369,0x1.a107,0x1.9ea9,0x1.9c4d,0x1.99f6,0x1.97a1,0x1.9550,0x1.9302,0x1.90b8,0x1.8e71,0x1.8c2e,0x1.89ed,0x1.87b0,0x1.8576,0x1.8340,0x1.810c,0x1.7edc,0x1.7caf,0x1.7a85,0x1.785f,0x1.763b,0x1.741b,0x1.71fd,0x1.6fe3,0x1.6dcc,0x1.6bb8,0x1.69a7,0x1.6798,0x1.658d,0x1.6385,0x1.6180,0x1.5f7e,0x1.5d7e,0x1.5b82,0x1.5988,0x1.5792,0x1.559e,0x1.53ad,0x1.51bf,0x1.4fd3,0x1.4deb,0x1.4c05,0x1.4a22,0x1.4842,0x1.4664,0x1.4489,0x1.42b1,0x1.40dc,0x1.3f09,0x1.3d39,0x1.3b6b,0x1.39a0,0x1.37d8,0x1.3612,0x1.344f,0x1.328f,0x1.30d1,0x1.2f15,0x1.2d5c,0x1.2ba6,0x1.29f2,0x1.2841,0x1.2692,0x1.24e5,0x1.233b,0x1.2193,0x1.1fee,0x1.1e4b,0x1.1cab,0x1.1b0c,0x1.1971,0x1.17d7,0x1.1640,0x1.14ab,0x1.1319,0x1.1189,0x1.0ffb,0x1.0e6f,0x1.0ce5,0x1.0b5e,0x1.09d9,0x1.0857,0x1.06d6,0x1.0558,0x1.03db,0x1.0261,0x1.00e9,0x.ff74,0x.fe00,0x.fc8f,0x.fb1f,0x.f9b2,0x.f847,0x.f6dd,0x.f576,0x.f411,0x.f2ae,0x.f14d,0x.efee,0x.ee91,0x.ed36,0x.ebdd,0x.ea86,0x.e930,0x.e7dd,0x.e68c,0x.e53c,0x.e3ef,0x.e2a3,0x.e15a,0x.e012,0x.decc,0x.dd88,0x.dc45,0x.db05,0x.d9c6,0x.d889,0x.d74e,0x.d615,0x.d4de,0x.d3a8,0x.d274,0x.d142,0x.d012,0x.cee3,0x.cdb6,0x.cc8b,0x.cb61,0x.ca39,0x.c913,0x.c7ee,0x.c6cc,0x.c5aa,0x.c48b,0x.c36d,0x.c251,0x.c136,0x.c01d,0x.bf05,0x.bdef,0x.bcdb,0x.bbc8,0x.bab7,0x.b9a7,0x.b899,0x.b78d,0x.b682,0x.b578,0x.b470,0x.b36a,0x.b265,0x.b161,0x.b05f,0x.af5f,0x.ae5f,0x.ad62,0x.ac66,0x.ab6b,0x.aa71,0x.a979,0x.a883,0x.a78e,0x.a69a,0x.a5a8,0x.a4b7,0x.a3c7,0x.a2d9,0x.a1ec,0x.a100,0x.a016,0x.9f2d,0x.9e45,0x.9d5f,0x.9c7a,0x.9b97,0x.9ab4,0x.99d3,0x.98f3,0x.9815,0x.9738,0x.965c,0x.9581,0x.94a7,0x.93cf,0x.92f8,0x.9222,0x.914e,0x.907a,0x.8fa8,0x.8ed7,0x.8e07,0x.8d39,0x.8c6b,0x.8b9f,0x.8ad4,0x.8a0a,0x.8941,0x.8879,0x.87b3,0x.86ed,0x.8629,0x.8566,0x.84a4,0x.83e3,0x.8323,0x.8264,0x.81a7,0x.80ea,0x.802e,0x.7f74,0x.7eba,0x.7e02,0x.7d4b,0x.7c94,0x.7bdf,0x.7b2b,0x.7a78,0x.79c6,0x.7915,0x.7864,0x.77b5,0x.7707,0x.765a,0x.75ae,0x.7503,0x.7458,0x.73af,0x.7307,0x.725f,0x.71b9,0x.7114,0x.706f,0x.6fcb,0x.6f29,0x.6e87,0x.6de6,0x.6d46,0x.6ca7,0x.6c09,0x.6b6c,0x.6ad0,0x.6a35"


	-- c coefficient = exp(-2*pi()*bandwidth/5512.5)  final value needs to be negative
	c_factor=split"1,0x.fd19,0x.fa3a,0x.f764,0x.f497,0x.f1d1,0x.ef13,0x.ec5e,0x.e9b0,0x.e70a,0x.e46c,0x.e1d5,0x.df46,0x.dcbe,0x.da3d,0x.d7c4,0x.d552,0x.d2e7,0x.d083,0x.ce26,0x.cbd0,0x.c981,0x.c738,0x.c4f6,0x.c2bb,0x.c086,0x.be57,0x.bc2f,0x.ba0d,0x.b7f1,0x.b5dc,0x.b3cc,0x.b1c2,0x.afbf,0x.adc1,0x.abc9,0x.a9d6,0x.a7e9,0x.a602,0x.a421,0x.a244,0x.a06e,0x.9e9c,0x.9cd0,0x.9b09,0x.9947,0x.978a,0x.95d3,0x.9420,0x.9272,0x.90c9,0x.8f25,0x.8d86,0x.8beb,0x.8a55,0x.88c4,0x.8737,0x.85af,0x.842b,0x.82ac,0x.8130,0x.7fba,0x.7e47,0x.7cd9,0x.7b6e,0x.7a08,0x.78a6,0x.7748,0x.75ee,0x.7498,0x.7346,0x.71f7,0x.70ad,0x.6f66,0x.6e22,0x.6ce3,0x.6ba7,0x.6a6f,0x.693a,0x.6809,0x.66db,0x.65b0,0x.6489,0x.6366,0x.6245,0x.6128,0x.600e,0x.5ef7,0x.5de4,0x.5cd3,0x.5bc6,0x.5abc,0x.59b5,0x.58b0,0x.57af,0x.56b1,0x.55b5,0x.54bc,0x.53c7,0x.52d4,0x.51e3,0x.50f6,0x.500b,0x.4f22,0x.4e3d,0x.4d5a,0x.4c79,0x.4b9c,0x.4ac0,0x.49e7,0x.4911,0x.483d,0x.476b,0x.469c,0x.45cf,0x.4505,0x.443c,0x.4376,0x.42b3,0x.41f1,0x.4132,0x.4075,0x.3fba,0x.3f01,0x.3e4a,0x.3d95,0x.3ce3,0x.3c32,0x.3b83,0x.3ad7,0x.3a2c,0x.3983,0x.38dc,0x.3837,0x.3794,0x.36f3,0x.3653,0x.35b6,0x.351a,0x.3480,0x.33e8,0x.3351,0x.32bc,0x.3229,0x.3197,0x.3107,0x.3079,0x.2fed,0x.2f62,0x.2ed8,0x.2e50,0x.2dca,0x.2d45,0x.2cc2,0x.2c40,0x.2bbf,0x.2b40,0x.2ac3,0x.2a47,0x.29cc,0x.2953,0x.28db,0x.2864,0x.27ef,0x.277b,0x.2709,0x.2698,0x.2628,0x.25b9,0x.254b,0x.24df,0x.2474,0x.240a,0x.23a2,0x.233b,0x.22d4,0x.226f,0x.220b,0x.21a9,0x.2147,0x.20e6,0x.2087,0x.2029,0x.1fcb,0x.1f6f,0x.1f14,0x.1eba,0x.1e60,0x.1e08,0x.1db1,0x.1d5b,0x.1d06,0x.1cb2,0x.1c5e,0x.1c0c,0x.1bbb,0x.1b6a,0x.1b1b,0x.1acc,0x.1a7e,0x.1a31,0x.19e5,0x.199a,0x.1950,0x.1907,0x.18be,0x.1876,0x.182f,0x.17e9,0x.17a4,0x.175f,0x.171b,0x.16d8,0x.1696,0x.df50,0x.1614,0x.15d3,0x.1594,0x.1556,0x.1518,0x.14da,0x.149e,0x.cbd9,0x.1427,0x.13ec,0x.13b3,0x.137a,0x.1341,0x.1309,0x.12d2,0x.ba15,0x.1265,0x.1230,0x.11fb,0x.11c7,0x.1193,0x.1160,0x.112e,0x.a9de,0x.10cb,0x.109a,0x.106a,0x.103a,0x.100b,0x.0fdd,0x.0faf,0x.9b10,0x.0f54,0x.0f28,0x.0efc,0x.0ed0,0x.0ea5,0x.0e7b,0x.0e51,0x.8d8c,0x.0dfe,0x.0dd6,0x.0dad,0x.0d86,0x.0d5e,0x.0d38,0x.0d11,0x.8136,0x.0cc6,0x.0ca1,0x.0c7c,0x.0c58,0x.0c34,0x.0c11,0x.0bee,0x.0bcb,0x.0ba9,0x.0b87,0x.0b66,0x.0b45,0x.0b24,0x.0b03"

	

	function say(speech)

		local segments=split(speech,";")
		local c1,c2,c,d2,volume,velocity,slide={},{}
		local v0,v1,v2,v_stress, d_stress, p_stress,h_phone,previous_phoneme=unpack(split("0,0,0,1,1,0,0")) 
		local function copy_cascade()
			cascade={}
			for m=1,#c do
				add(cascade,{unpack(c[m])})
			end
		end
		local function add_sound()
			copy_cascade()
			if  h_phone >0 then  -- hh with formants borrowed from vowel
				add(sounds,{h_phone,1,0,16,16,pitch,delta_f0,v_stress,cascade,c2})
				v1=16
				h_phone=0
				copy_cascade()
			end
			add(sounds,{max(d2,1),source,frication,v1,v2,pitch,delta_f0,v_stress,cascade,c2})	
		end
				
		for i, segment in pairs(segments) do
		
			local d_stress,v_stress,p_stress,phoneme= unpack(split(segment))
			
			for frame in all(phone[phoneme]) do
				if phoneme=="hh" then
					h_phone=max(frame[1]*d_stress/spk8_rate,1)
				else
					
					v1=v2 --v1 is now past phone's ending volume, v2
					
					if (i>1) then  -- add second half of segment
	
						if (velocity >0 and phoneme !="_") v2=frame[3] --v2 is next frame's target volume if not going into pause or if second half is not a non-sonorant
						-- cascade has already made the journey from c1 to c2.  now taper volume to next frame
						c=c2
						add_sound()
					end	
										
					d,source,v2,frication,velocity,slide,pitch,formants=unpack(frame) --unpack next frame and make it current
					--if (phoneme=="_") frication=previous_frication
					--cascade c is empty table, previous ending cascade assigned to c1
					--c2 is assigned ending cascade for this phoneme frame 
				
					c,d2,c1,c2,delta_f0={},max(d*d_stress/spk8_rate\2,1),c2,formants,p_stress*spk8_intonation+pitch*spk8_if0
					
					--c1 is previous phone's ending cascade, c2
					--c2 is new phone's formants.
					--v1 is past phone's ending volume
					--v1 is current phone's target volume
					--v2 is future phone's target volume
					
					--formants will be blended from previous sound unless
					if (slide == 0 or previous_phoneme=="_") c1=formants 

					if (velocity == 0 ) v1=v2  -- do no blend volume for non-sonorants
					c=c1
					
					
					add_sound()
					previous_phoneme=phoneme
				end
			end	
		end	
		y0,y1,y2=split"0,0,0",split"0,0,0",split"0,0,0"
		p0,p1,p2=split"0,0,0",split"0,0,0",split"0,0,0"
		ylnp2c,ylnp1c,t=0,0,0

	end
	function speaking() return #sounds>0 end
	function mute() sounds,duration,counter={},0,0 end
	function speako8()

		while stat(108)<1920 do
			for i=0,127 do
				if t % w0 ==0 then
					if counter< 1 then
						if #sounds>0 then
							duration,source,frication,v1,v2,pitch,delta_f0,v_stress,cascade,cascade2=unpack(deli(sounds,1))
							if (source !=2) f0= spk8_pitch+delta_f0
							velocity,t,v,counter =0,0,v1,duration
							acceleration=2*(v2-v)/duration/duration
							if acceleration < 0 then
								acceleration*=-1
								velocity=acceleration*(.5 - duration)
							end
						else
							--if (i>0) serial(0x808,buffer,i+1)  
							return
						end
					end
					amplitude,t=v*(1-spk8_aspiration)*v_stress*3,0
				end
				
					noise=.75*noise+.25*(rnd(1)-.5)
					sample=0
					if source !=3 then --if not silence

						parallel=noise*frication
						parallel_sample=parallel
						if source > 1 then  -- voiced phones
							-- KLGLOTT88 model of glottal wave
							f0= (spk8_pitch+delta_f0)*.02+f0*.98 --moving average of pitch n=50		
							w0=ceil(5512.5/f0)
							open=w0*spk8_quality
							if (t<open) then		--opening phase of vocal folds
								x0=(1-spk8_tilt)*amplitude*((t/open)^2 -(t/open)^3) +spk8_tilt*x0
							else
								x0=spk8_tilt*x0  --taper off amplitude
							end
							-- sample = glottal wave + aspiration - dc offset
							sample=x0+noise*spk8_aspiration-amplitude*spk8_quality/12
						end
						--resonate to create formants (iir filter-- Klatt Synth 1980)
						for k,resonator in pairs(cascade) do
							local bw,f=mid(1,resonator[2]*spk8_bandwidth\10,#b_factor),resonator[1]*spk8_shift
							b1=cos(f/5512.5)	
							if k==4 then -- nasal filter
								if source != 0 then  --no nasality for voiceless fricatives
									local b0=b100*b1  -- calculate b coefficient
									local a0 =1-b0-c100
									yzc=(sample - b0*ylnz1c - c100*ylnz2c)/a0
									ylnz2c,ylnz1c,b0=ylnz1c,sample,b100*cos(270/5512.5)
									sample=a0*yzc+b0*ylnp1c+ c100*ylnp2c
									ylnp2c,ylnp1c=ylnp1c,sample 
								end	
							else -- formant filters
								y2[k],y1[k]=y1[k],y0[k]
								p2[k],p1[k]=p1[k],p0[k]
								local b0,c0=b_factor[bw]*b1,-c_factor[bw]
								local a0=1-b0-c0
								y0[k]=a0*sample +b0*y1[k] + c0*y2[k]
								p0[k]=a0*parallel_sample +b0*p1[k] + c0*p2[k]

								sample=y0[k]  --process voiced, hh, and silence as cascaded formants
								parallel+=p0[k] -- parallel formants for frication
							end
										
							if counter>0 then
								resonator[1]+=(cascade2[k][1]-resonator[1])/counter
								resonator[2]+=(cascade2[k][2]-resonator[2])/counter
							end	
							
							
						end
						--if (source ==0) then 
						--	sample=parallel --unvoiced fricatives
						--else	
							--sample+=parallel--add frication
						--end	
						v+=velocity
						velocity+=acceleration
					end
			
					t+=1
					counter-=1
					poke(buffer+i,(sample+parallel)*spk8_volume+128)
			--	end	
			end
			serial(0x808,buffer,128)	
		end
	end	
end