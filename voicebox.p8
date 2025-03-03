pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
buffer=0x8000
function _init()
    w0=30
    t=0
    amplitude=50
    dc=amplitude/w0
    
    tilt=1
    x0,x1,e,pi=0,0,0x2.b7e1,0x3.243f
    bandwidth={}
    for bw=0,400 do 
        bandwidth[bw]=e^(-pi*bw/551.25)
    end
    db=split"3.162,10,31.62,100,316,1000,3162,10000,31623" --db[6]=60 decibels = 1000 amplitude
    
    source={}
   
    --f,f_step,bw,bw_step,y0,y1,y2
    add(source,{0,0,10,0,0,0,0}) --rpg
    add(source,{-1500/5512.5,0,100,0,0,0,0}) --rnz
    
    formants={}
   
    add(formants,{2900/5512.5,0,7,0,0,0,0})--f3
    add(formants,{2200/5512.5,0,7,0,0,0,0})--f2
    add(formants,{310/5512.5,0,13,0,0,0,0})--f1
    add(formants,{-270/5512.5,0,10,0,0,0,0})--Nasal zero
    add(formants,{270/5512.5,0,10,0,0,0,0})--Nasal pole
  
    

end
function _update()
    voicebox()
end
function new_resonator(frequency,radius) -- negative frequency indicates anti-resonator
    local b,c=2 * radius*cos(frequency/5512.5), - radius*radius
    local a=1-b-c
    if  sgn(frequency)==-1 then -- anti-resonator 
       print(1/a.." "..-b/a.." "..-c/a)
        return{a=1/a,b=-b/a,c=-c/a,y0=0,y1=0,y2=0}
    else
       return {a=a,b=b,c=c,y0=0,y1=0,y2=0}
    end
end
function resonate(resonator,x0)
    for j=1, #resonator do
        local f,f_step,bw,bw_step,y1,y2=unpack(resonator[j]) --f,f_step,bw,bw_step,y0,y1,y2
        local y0,r=y1,bandwidth[bw]
        local b,c=2*r*cos(f),-r*r
        local a=1-b-c
        if f<0 then
            y0,a,b,c=x0,1/a,-b/a,-c/a
        end
        x0=a*x0+b*y1+c*y2
        if (f>=0) y0=x0
        resonator[j]={f,f_step,bw,bw_step,y0,y1,y2}
    end
    return x0
end

function voicebox()
    while stat(108)<1024 do
        for i=0,255  do
            if t % w0 ==0 then
                x0=amplitude -dc -- -500 --(4-2)*w0
                t=0
            else
                x0=-dc--(0-2)*w0
            end
            x0=resonate(source,x0)
            x0*=db[4]
            x1,x0=x0,x0-x1
             x0=resonate(formants,x0)
            poke(buffer+i,x0+127)
            t+=1
        end
       
       
        
        serial(0x808,buffer,256)	
    end
end	

function _draw()
    cls()
    line(0,64,127,64,3)

    for i=0,127 do
        cursamp=128-(peek(buffer+(i))/2)
        if i==0 then
            pset(i,cursamp,11)
        else
            line(i-1,prvsamp,i,cursamp,11)
            pset(i,cursamp,11)
        end
        prvsamp=cursamp
    end
   
end