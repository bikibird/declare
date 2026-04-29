pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
buffer=0x8000

do 
 
    w0=40
    open=20
    tilt=5
    smoothing=.4
    t=0
    amplitude=20
    dc=open/2/w0
    x0,x1,e,pi=0,0,0x2.b7e1,0x3.243f
    b,c,cos_f={},{},{}
    for bw=0,400 do
        local r=e^(-pi*bw/551.25) 
        b[bw],c[bw],cos_f[bw]=2*r,-r*r,cos(bw/551.25)
    end
    db=split"3.162,10,31.62,100,316,1000,3162,10000,31623" --db[6]=60 decibels = 1000 amplitude
    function resonate(resonator)
        for i=1, #resonator do
            local f,f_step,bw,bw_step,y1,y2=unpack(resonator[i]) --fc, f,f_step,bwc,bw,bw_step,y0,y1,y2
            local y0=y1
            local b,c=b[bw]*cos_f[abs(f)],c[bw]
            local a=1-b-c
            if f<0 then --anti-resonate
                y0=x0 -- y0 must be assigned before x0 update
                x0=(x0-b*y1-c*y2)/a
            else --resonate
                x0=a*x0+b*y1+c*y2
                y0=x0  -- y0 must be assigned after x0 update
            end
            f+=f_step
            bw+=bw_step
            resonator[i]={f,f_step,bw,bw_step,y0,y1,y2}
           -- if (i==1) iw0=spk8_inherent_w0*(f-spk8_f1[1])/f1_range
        end
        return x0
    end
    function get_formant(f,bw,anti_resonator)
        local r=e^(-pi*bw/5512.5)
        local b,c=2*r*cos(f/5512.5),-r*r
        local a=1-b-c
        --{a,b,c,a_step,b_step,c_step,y1,y2}
        return {anti_resonator,a,b,c,0,0,0,0,0}
    end



    function speako8()
        while stat(108)<512 do
            for i=0,255  do
                if t>open then -- part 3 closed vocal cords
                    x0=0
                else
                    x0=1 
                    if t>tilt then --part 2 falling slope
                        x0-=(t-tilt)/(open-tilt) 
                    else 
                        if (t>0) x0+=t/tilt -- part 1 rising slope
                    end
                end    
                x0-=dc
                x0=x0*(1-smoothing)+ x1*smoothing
                x1=x0
                poke(buffer+i,resonate(formants)*amplitude+127)
                --poke(buffer+i,x0*amplitude+127)
                t=(t+1)%w0
                
            end
            serial(0x808,buffer,256)	
        end
    end
    
end
function _init()
    formants={}

    add(formants,{290,0,7,0,0,0,0})--f3
    add(formants,{220,0,7,0,0,0,0})--f2
    add(formants,{31,0,13,0,0,0,0})--f1
    add(formants,{-27,0,10,0,0,0,0})--Nasal zero
    add(formants,{27,0,10,0,0,0,0})--Nasal pole
  
end
function _update()
    if (btnp(0)) tilt-=1
    if (btnp(1)) tilt+=1
    if (btnp(2)) smoothing-=.01
    if (btnp(3)) smoothing+=.01
    
   speako8()
end
function _draw()
    cls()
    line(0,64,127,64,3)
    print(tilt,0,0,8)
    print(smoothing,0,10,8)
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