pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
buffer=0x8000
function _init()
    w0=20
    t=0
    smoothing=.1
    sample=-1
    dc=2000/w0
  --  a,b,c=0.0030688064,1.889206383,-0.8922751893
    
    y0,y1,y2=-0,0,0
    e,pi=0x2.b7e1,0x3.243f
    bandwidth={}
    for bw=0,900 do 
        bandwidth[bw]=e^(-pi*bw*551.25)
    end
    resonators={}
    add(resonators,new_resonator(0,bandwidth[10])) --low pass filter
    add(resonators,new_resonator(-1500,bandwidth[600])) -- tilt
    add(resonators,new_resonator(2600,bandwidth[10])) --f3
    add(resonators,new_resonator(1220,bandwidth[7])) -- f2
    add(resonators,new_resonator(700,bandwidth[13])) --f1
    add(resonators,new_resonator(270,bandwidth[10])) -- Nasal Pole
    add(resonators,new_resonator(-270,bandwidth[10])) -- Nasal zero
    
    
   





end

function new_resonator(frequency,radius) -- negative frequency indicates anti-resonator
    local b,c,d=2 * radius*cos(frequency/5512.5), - radius*radius,1
    local a=1-b-c
    if  sgn(frequency)==-1 then -- anti-resonator 
        d,a,b,c=a,1,-b,-c
    end
    print(a.." "..b.." "..c.." "..d)
    return {a=a,b=b,c=c,d=d,y0=0,y1=0,y2=0}
end

function _update()

    voicebox(resonators)

end
function voicebox(resonators)
    
    while stat(108)<1024 do
        for i=0,255  do
            if t % w0 ==0 then
               sample=500*w0 -500
               t=0
            else
              sample= -500
            end
            for resonator in all(resonators) do
                resonator.y2,resonator.y1=resonator.y1,resonator.y0
                resonator.y0=(resonator.a*sample+resonator.b*resonator.y1+resonator.c*resonator.y2)/resonator.d
                sample=resonator.y0*1.4
            end
            poke(buffer+i,sample+128)
            t+=1
        end
        serial(0x808,buffer,256)	
    end
end	

function _draw()
    cls()
    line(0,63,127,63,3)
    line(0,64,127,64,3)
    for i=0,127 do
        cursamp=(peek(buffer+(i*2))/2)
        if i==0 then
            pset(i,cursamp,11)
        else
            line(i-1,prvsamp,i,cursamp,11)
            pset(i,cursamp,11)
        end
        prvsamp=cursamp
    end
end