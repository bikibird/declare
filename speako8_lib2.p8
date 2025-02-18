pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
do

	poke(0x5f36,@0x5f36^^0x20) --turn off pcm channel dampening

	--=duration,source (frication=0 aspriation=1 voicing=2 silence=3),volume,velocity,slide,frication,inherent f0, f3, f3:bandwith,f2,f2:bw,f1,f1:bw,nasal frequency, nasal bandwidth
	
	
	data=split("aa=1320,2,89,0,4,2,1,260,16,122,7,70,13,27,10;ae=630,2,89,0,4,2,.79,243,30,166,13,62,7,27,10/630,2,100,0,4,2,.79,247,30,149,13,65,7,27,10;ah=770,2,96,0,4,2,.79,255,14,122,5,62,8,27,10;ao=1320,2,93,0,4,2,.74,257,8,99,10,60,9,27,10;aw=715,2,89,0,4,2,.79,255,11,123,7,64,8,27,10/715,2,89,0,4,2,0,235,11,94,7,42,8,27,10;ay=685,2,93,0,4,2,.9,255,20,120,12,66,10,27,10/685,2,93,0,4,2,.223,250,20,188,12,40,10,27,10;eh=410,2,104,0,4,2,.44,250,20,168,9,53,6,27,10/410,2,104,0,4,2,.44,253,20,153,9,62,6,27,10;rr=495,2,108,0,4,2,.41,154,11,127,6,47,10,27,10/495,2,108,0,4,2,.41,170,14,150,8,45,6,27,10;ar=715,2,100,0,4,2,1,238,11,117,6,68,6,27,10/715,2,100,0,4,2,.41,165,11,140,6,52,6,27,10;er=740,2,100,0,4,2,.44,240,14,165,8,46,6,27,10/740,2,100,0,4,2,.41,170,14,150,8,45,6,27,10;ir=630,2,100,0,4,2,.23,290,12,190,8,32,7,27,10/630,2,100,0,4,2,.41,175,12,155,8,42,7,27,10;or=660,2,100,0,4,2,.74,220,6,82,6,55,6,27,10/660,2,100,0,4,2,.41,150,6,130,6,49,6,27,10;ur=630,2,100,0,4,2,.36,200,8,80,6,36,6,27,10/630,2,100,0,4,2,.41,150,8,115,6,39,6,27,10;ey=520,2,96,0,4,2,.44,252,20,172,10,48,7,27,10/520,2,96,0,4,2,.05,260,20,220,10,33,7,27,10;ih=370,2,100,0,4,2,.23,267,14,180,10,40,5,27,10/370,2,100,0,4,2,.23,267,14,180,10,40,5,27,10;iy=425,2,100,0,4,2,0,296,40,220,20,31,5,27,10/425,2,100,0,4,2,0,298,40,207,20,29,5,27,10;ow=575,2,100,0,4,2,.59,230,7,110,7,54,8,27,10/575,2,100,0,4,2,.59,230,7,90,7,45,8,27,10;oy=513,2,108,4,0,2,.62,240,16,96,12,55,8,27,10/513,2,108,0,4,2,.13,245,16,182,12,36,16,27,10/513,2,108,0,4,2,.13,240,13,182,5,36,8,27,10;uh=220,2,112,0,4,2,.36,235,8,110,10,45,8,27,10/220,2,112,0,4,2,.36,239,8,118,10,50,8,27,10;uw=575,2,117,0,4,2,.1,220,14,125,11,35,7,27,10/575,2,117,0,4,2,-.12,220,14,90,11,32,7,27,10;l=440,2,68,0,4,2,0,280,28,105,10,33,5,27,10;lx=490,2,100,0,4,2,0,285,7,80,6,45,8,27,10;el=1430,2,89,0,4,2,.79,285,8,80,6,45,7,27,10;r=440,2,89,0,1,2,0,156,7,126,6,46,6,27,10;em=465,2,68,0,4,2,.79,210,7,90,6,20,12,27,10/465,2,100,0,4,2,0,215,20,110,15,40,30,45,10;m=380,2,71,0,0,0,0,215,20,110,15,40,30,45,10;en=465,2,68,0,4,2,.79,270,26,140,30,48,4,27,10/465,2,100,0,4,2,0,260,17,160,10,20,6,45,10;n=330,2,71,0,0,0,0,260,17,160,10,20,6,45,10;ng=520,2,71,0,0,0,0,205,10,169,15,48,10,45,16;ch=380,2,0,0,0,0,0,240,27,170,11,30,20,27,10;chx=80,0,7,0,0,0,0,-240,27,170,11,30,20,27,10;sh=570,0,1,1,0,0,0,-240,28,165,11,40,20,27,10;zh=380,1,1,79,1,0,0,-240,25,-165,14,30,22,27,10;jh=380,2,0,0,0,0,0,-240,27,170,11,20,5,27,10;jhx=55,2,79,.10,0,0,0,-240,27,170,11,20,5,27,10;dh=270,2,79,.4,0,0,0,270,19,115,10,30,6,27,10;f=550,0,100,0,0,0,0,210,18,113,12,40,23,27,10;s=570,0,0,1,0,0,0,270,22,140,10,40,20,27,10;k=440,2,0,0,0,0,0,190,28,160,22,35,25,27,10;kx=140,0,0,1,0,0,0,190,28,160,22,35,25,27,10;p=490,2,0,0,0,0,0,215,22,110,15,40,30,27,10;px=44,0,0,1,0,0,0,215,22,110,15,40,30,27,10;t=410,2,0,0,0,0,0,270,22,140,18,30,30,27,10;tx=80,0,1,0,0,0,0,270,22,140,18,30,30,27,10;g=440,2,0,0,0,0,0,190,19,160,15,25,7,27,10;gx=110,2,79,0,0,0,0,190,19,160,15,25,7,27,10;b=460,2,0,0,0,0,0,210,13,90,9,20,7,27,10;bx=30,2,79,0,0,0,0,210,13,90,9,20,7,27,10;d=380,2,0,0,0,0,0,270,18,140,12,20,7,27,10;dx=55,2,79,0,0,0,0,270,18,140,12,20,7,27,10;dd=110,2,0,0,0,0,0,270,25,160,14,20,12,27,10;ddx=55,2,100,0,0,0,0,270,25,160,14,20,12,27,10;th=490,0,0,1,0,0,0,270,20,115,10,40,23,27,10;v=330,2,46,1,0,0,0,210,13,113,10,30,6,27,10;z=410,2,46,1,0,0,0,270,19,140,9,30,7,27,10;w=440,2,89,0,0,2,0,215,6,61,8,29,5,27,10;y=440,2,89,0,0,2,0,302,50,207,25,24,4,27,10;hh=440,0,0,0,0,0,0,0,0,0,0,0,0,27,100;_=550,2,0,0,0,0,0,250,12,150,6,43,12,27,10/550,2,0,0,0,0,0,250,12,150,6,43,12,27,10;~=400,1,1,1,1,1,0,250,12,150,6,43,12,27,10",";")
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
	local f00,f0,w0,yzc,ylnz1c,ylnz2c,ylnp1c,ylnp2c,sample,x0,noise,t,duration,counter,velocity,v,buffer,b100,c100,bz,source,delta_f0,y0,y1,y2,p0,p1,p2,frication,pitch,cascade,cascade2,formants,open,b1,amplitude,v_stress,v1,v2,parallel,parallel_sample=unpack(split"140,140,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0x8000,0x1.233b,-0x.52d4,0x1.159")
	sounds={}
	 
	-- b coefficient first factor = =2*exp(-pi()*bandwidth/5512.5)  
	b_factor=split"2,0x1.fd17,0x1.fa32,0x1.f752,0x1.f475,0x1.f19d,0x1.eec9,0x1.ebfa,0x1.e92e,0x1.e666,0x1.e3a3,0x1.e0e3,0x1.de27,0x1.db70,0x1.d8bc,0x1.d60c,0x1.d360,0x1.d0b9,0x1.ce14,0x1.cb74,0x1.c8d8,0x1.c63f,0x1.c3aa,0x1.c119,0x1.be8c,0x1.bc02,0x1.b97c,0x1.b6fa,0x1.b47b,0x1.b200,0x1.af89,0x1.ad15,0x1.aaa5,0x1.a838,0x1.a5cf,0x1.a369,0x1.a107,0x1.9ea9,0x1.9c4d,0x1.99f6,0x1.97a1,0x1.9550,0x1.9302,0x1.90b8,0x1.8e71,0x1.8c2e,0x1.89ed,0x1.87b0,0x1.8576,0x1.8340,0x1.810c,0x1.7edc,0x1.7caf,0x1.7a85,0x1.785f,0x1.763b,0x1.741b,0x1.71fd,0x1.6fe3,0x1.6dcc,0x1.6bb8,0x1.69a7,0x1.6798,0x1.658d,0x1.6385,0x1.6180,0x1.5f7e,0x1.5d7e,0x1.5b82,0x1.5988,0x1.5792,0x1.559e,0x1.53ad,0x1.51bf,0x1.4fd3,0x1.4deb,0x1.4c05,0x1.4a22,0x1.4842,0x1.4664,0x1.4489,0x1.42b1,0x1.40dc,0x1.3f09,0x1.3d39,0x1.3b6b,0x1.39a0,0x1.37d8,0x1.3612,0x1.344f,0x1.328f,0x1.30d1,0x1.2f15,0x1.2d5c,0x1.2ba6,0x1.29f2,0x1.2841,0x1.2692,0x1.24e5,0x1.233b,0x1.2193,0x1.1fee,0x1.1e4b,0x1.1cab,0x1.1b0c,0x1.1971,0x1.17d7,0x1.1640,0x1.14ab,0x1.1319,0x1.1189,0x1.0ffb,0x1.0e6f,0x1.0ce5,0x1.0b5e,0x1.09d9,0x1.0857,0x1.06d6,0x1.0558,0x1.03db,0x1.0261,0x1.00e9,0x.ff74,0x.fe00,0x.fc8f,0x.fb1f,0x.f9b2,0x.f847,0x.f6dd,0x.f576,0x.f411,0x.f2ae,0x.f14d,0x.efee,0x.ee91,0x.ed36,0x.ebdd,0x.ea86,0x.e930,0x.e7dd,0x.e68c,0x.e53c,0x.e3ef,0x.e2a3,0x.e15a,0x.e012,0x.decc,0x.dd88,0x.dc45,0x.db05,0x.d9c6,0x.d889,0x.d74e,0x.d615,0x.d4de,0x.d3a8,0x.d274,0x.d142,0x.d012,0x.cee3,0x.cdb6,0x.cc8b,0x.cb61,0x.ca39,0x.c913,0x.c7ee,0x.c6cc,0x.c5aa,0x.c48b,0x.c36d,0x.c251,0x.c136,0x.c01d,0x.bf05,0x.bdef,0x.bcdb,0x.bbc8,0x.bab7,0x.b9a7,0x.b899,0x.b78d,0x.b682,0x.b578,0x.b470,0x.b36a,0x.b265,0x.b161,0x.b05f,0x.af5f,0x.ae5f,0x.ad62,0x.ac66,0x.ab6b,0x.aa71,0x.a979,0x.a883,0x.a78e,0x.a69a,0x.a5a8,0x.a4b7,0x.a3c7,0x.a2d9,0x.a1ec,0x.a100,0x.a016,0x.9f2d,0x.9e45,0x.9d5f,0x.9c7a,0x.9b97,0x.9ab4,0x.99d3,0x.98f3,0x.9815,0x.9738,0x.965c,0x.9581,0x.94a7,0x.93cf,0x.92f8,0x.9222,0x.914e,0x.907a,0x.8fa8,0x.8ed7,0x.8e07,0x.8d39,0x.8c6b,0x.8b9f,0x.8ad4,0x.8a0a,0x.8941,0x.8879,0x.87b3,0x.86ed,0x.8629,0x.8566,0x.84a4,0x.83e3,0x.8323,0x.8264,0x.81a7,0x.80ea,0x.802e,0x.7f74,0x.7eba,0x.7e02,0x.7d4b,0x.7c94,0x.7bdf,0x.7b2b,0x.7a78,0x.79c6,0x.7915,0x.7864,0x.77b5,0x.7707,0x.765a,0x.75ae,0x.7503,0x.7458,0x.73af,0x.7307,0x.725f,0x.71b9,0x.7114,0x.706f,0x.6fcb,0x.6f29,0x.6e87,0x.6de6,0x.6d46,0x.6ca7,0x.6c09,0x.6b6c,0x.6ad0,0x.6a35"


	-- c coefficient = exp(-2*pi()*bandwidth/5512.5)  final value needs to be negative
	c_factor=split"1,0x.fd19,0x.fa3a,0x.f764,0x.f497,0x.f1d1,0x.ef13,0x.ec5e,0x.e9b0,0x.e70a,0x.e46c,0x.e1d5,0x.df46,0x.dcbe,0x.da3d,0x.d7c4,0x.d552,0x.d2e7,0x.d083,0x.ce26,0x.cbd0,0x.c981,0x.c738,0x.c4f6,0x.c2bb,0x.c086,0x.be57,0x.bc2f,0x.ba0d,0x.b7f1,0x.b5dc,0x.b3cc,0x.b1c2,0x.afbf,0x.adc1,0x.abc9,0x.a9d6,0x.a7e9,0x.a602,0x.a421,0x.a244,0x.a06e,0x.9e9c,0x.9cd0,0x.9b09,0x.9947,0x.978a,0x.95d3,0x.9420,0x.9272,0x.90c9,0x.8f25,0x.8d86,0x.8beb,0x.8a55,0x.88c4,0x.8737,0x.85af,0x.842b,0x.82ac,0x.8130,0x.7fba,0x.7e47,0x.7cd9,0x.7b6e,0x.7a08,0x.78a6,0x.7748,0x.75ee,0x.7498,0x.7346,0x.71f7,0x.70ad,0x.6f66,0x.6e22,0x.6ce3,0x.6ba7,0x.6a6f,0x.693a,0x.6809,0x.66db,0x.65b0,0x.6489,0x.6366,0x.6245,0x.6128,0x.600e,0x.5ef7,0x.5de4,0x.5cd3,0x.5bc6,0x.5abc,0x.59b5,0x.58b0,0x.57af,0x.56b1,0x.55b5,0x.54bc,0x.53c7,0x.52d4,0x.51e3,0x.50f6,0x.500b,0x.4f22,0x.4e3d,0x.4d5a,0x.4c79,0x.4b9c,0x.4ac0,0x.49e7,0x.4911,0x.483d,0x.476b,0x.469c,0x.45cf,0x.4505,0x.443c,0x.4376,0x.42b3,0x.41f1,0x.4132,0x.4075,0x.3fba,0x.3f01,0x.3e4a,0x.3d95,0x.3ce3,0x.3c32,0x.3b83,0x.3ad7,0x.3a2c,0x.3983,0x.38dc,0x.3837,0x.3794,0x.36f3,0x.3653,0x.35b6,0x.351a,0x.3480,0x.33e8,0x.3351,0x.32bc,0x.3229,0x.3197,0x.3107,0x.3079,0x.2fed,0x.2f62,0x.2ed8,0x.2e50,0x.2dca,0x.2d45,0x.2cc2,0x.2c40,0x.2bbf,0x.2b40,0x.2ac3,0x.2a47,0x.29cc,0x.2953,0x.28db,0x.2864,0x.27ef,0x.277b,0x.2709,0x.2698,0x.2628,0x.25b9,0x.254b,0x.24df,0x.2474,0x.240a,0x.23a2,0x.233b,0x.22d4,0x.226f,0x.220b,0x.21a9,0x.2147,0x.20e6,0x.2087,0x.2029,0x.1fcb,0x.1f6f,0x.1f14,0x.1eba,0x.1e60,0x.1e08,0x.1db1,0x.1d5b,0x.1d06,0x.1cb2,0x.1c5e,0x.1c0c,0x.1bbb,0x.1b6a,0x.1b1b,0x.1acc,0x.1a7e,0x.1a31,0x.19e5,0x.199a,0x.1950,0x.1907,0x.18be,0x.1876,0x.182f,0x.17e9,0x.17a4,0x.175f,0x.171b,0x.16d8,0x.1696,0x.df50,0x.1614,0x.15d3,0x.1594,0x.1556,0x.1518,0x.14da,0x.149e,0x.cbd9,0x.1427,0x.13ec,0x.13b3,0x.137a,0x.1341,0x.1309,0x.12d2,0x.ba15,0x.1265,0x.1230,0x.11fb,0x.11c7,0x.1193,0x.1160,0x.112e,0x.a9de,0x.10cb,0x.109a,0x.106a,0x.103a,0x.100b,0x.0fdd,0x.0faf,0x.9b10,0x.0f54,0x.0f28,0x.0efc,0x.0ed0,0x.0ea5,0x.0e7b,0x.0e51,0x.8d8c,0x.0dfe,0x.0dd6,0x.0dad,0x.0d86,0x.0d5e,0x.0d38,0x.0d11,0x.8136,0x.0cc6,0x.0ca1,0x.0c7c,0x.0c58,0x.0c34,0x.0c11,0x.0bee,0x.0bcb,0x.0ba9,0x.0b87,0x.0b66,0x.0b45,0x.0b24,0x.0b03"

	

	function say(speech)

		local segments=split(speech,";")
		local c1,c2,c,d2,slide={},{}
		local v1,v2,v_stress, d_stress, p_stress,h_phone,phoneme, previous_phoneme,d=unpack(split("0,0,1,1,0,0")) 
		local function copy_cascade()
			cascade={}
			for m=1,#c do
				add(cascade,{unpack(c[m])})
			end
		end
		local function add_sound()
			copy_cascade()
			add(sounds,{max(d2,1),source,af,v1,v2,pitch,delta_f0,v_stress,cascade,c2})	
		end
				
		for i, segment in pairs(segments) do
		
			d_stress,v_stress,p_stress,phoneme= unpack(split(segment))
			
			for frame in all(phone[phoneme]) do
				if phoneme!="hh" then
					
					v1=v2 --v1 is now past phone's ending volume, v2
					
					if (i>1) then  -- add second half of segment
	
						if (velocity >0 and phoneme !="_") v2=frame[3] --v2 is next frame's target volume if not going into pause or if second half is not a non-sonorant
						-- cascade has already made the journey from c1 to c2.  now taper volume to next frame
						c=c2
						add_sound()
					end	
										
					d,source,v2,af,velocity,slide,pitch,formants=unpack(frame) --unpack next frame and make it current
					--if (phoneme=="_") frication=previous_frication
					--cascade c is empty table, previous ending cascade assigned to c1
					--c2 is assigned ending cascade for this phoneme frame 
				
					d2,c1,c2,delta_f0=max(d*d_stress/spk8_rate\2,1),c2,formants,p_stress*spk8_intonation+pitch*spk8_if0
					
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
				else 	-- phoneme = hh
					h_phone=max(frame[1]*d_stress/spk8_rate,1)	
				end
			end	
		end	
		
		y0,y1,y2,p0,p1,p2=split"0,0,0",split"0,0,0",split"0,0,0",split"0,0,0",split"0,0,0",split"0,0,0"
		ylnp2c,ylnp1c,t,velocity=0,0,0,0
		
	end
	function speaking()
		return #sounds>0
	end
	function mute()
		sounds,duration,counter={},0,0 
	end
	function speako8()
		local one_minus_aspiration,shift=1-spk8_aspiration,spk8_shift/551.25
		while stat(108)<256 do
			for i=0,255  do
				if t % w0 ==0 then
					if counter< 1 then
						if #sounds>0 then
							duration,source,af,v1,v2,pitch,delta_f0,v_stress,cascade,cascade2=unpack(deli(sounds,1))
							if source !=2 then
								f0= spk8_pitch+delta_f0
								f00=f0
							end
							t,v,counter =0,v1,duration							
						else
							return
						end
					end
					amplitude,t=v*one_minus_aspiration*v_stress*.15,0
				end
				noise=.75*noise+.25*rnd(amplitude)
				--noise=.5*amplitude - rnd(amplitude)
				sample=amplitude
				
				
				if source !=3 then --if not silence
					parallel_sample=noise*af --af is amplitude of frication
					ps=parallel_sample
					
					if source > 1 then  -- voiced phones
						local s=t/w0*64  --sfx sample
						local s_flr=flr(s)
						local s_interpolation=s-s_flr
						sample*=(peek(0x3200+0+s_flr)*s_interpolation+peek(0x3200+0+s_flr+1)*(1-s_interpolation))/256
						
						f0= (f00)*.02+f0*.98 --moving average of pitch n=50		
						w0=ceil(5512.5/f0)
						sample+=noise*spk8_aspiration
					elseif source ==1 then	--hh phone
						sample=parallel_sample
					end
					--resonate to create formants (iir filter-- Klatt Synth 1980)

					for k,resonator in pairs(cascade) do
						local bw,f=mid(1,resonator[2]*spk8_bandwidth\1,#b_factor),resonator[1]
						b1=cos(f*shift)	
						if k==4 then -- nasal filter
							if source != 0 then  --no nasality for voiceless fricatives
								local b0=b100*b1  -- calculate b coefficient
								local a0 =1-b0-c100
								?1
								?b0
								?c100
								?a0
								stop()
								yzc=(sample - b0*ylnz1c - c100*ylnz2c)/a0
								ylnz2c,ylnz1,sample=ylnz1c,sample,yzc
								sample=a0*sample+bz*ylnp1c+ c100*ylnp2c --bz==b100*cos(270/5512.5)
								ylnp2c,ylnp1c=ylnp1c,sample 
							end	
						else -- formant filters
							y2[k],y1[k]=y1[k],y0[k]
							p2[k],p1[k]=p1[k],p0[k]
							local b0,c0=b_factor[bw]*b1,-c_factor[bw]
							local a0=1-b0-c0
						
							y0[k]=a0*sample +b0*y1[k] + c0*y2[k]
							sample=y0[k]  --process voiced and hh as cascaded formants
							if f<0 then 
								p0[k]=a0*ps +b0*p1[k] + c0*p2[k]
								parallel_sample+=p0[k] -- parallel formants for frication
							end
						end
						if counter>0 then
							resonator[1]+=(sgn(f)*abs(cascade2[k][1])-f)/counter
							resonator[2]+=(cascade2[k][2]-bw)/counter
						end	
					end
					v+=(v2-v)/counter
				end
				t+=1
				counter-=1
				poke(buffer+i,(sample+parallel_sample)*spk8_volume+128)
			end
			serial(0x808,buffer,256)	
		end
	end	
end