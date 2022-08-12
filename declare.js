declare=function(passage)
{

	var innateDuration={aa:1320,ae:1270,ah:660,ao:1320,aw:720,ay:690,eh:830,er:740,ey:1040,ih:720,iy:880,ow:1210,oy:1540,uh:880,uw:1170,l:440,r:440,m:390,n:360,ng:440,ch:385,jh:385,dh:275,f:660,s:690,sh:690,zh:385,k:360,p:470,t:360,g:360,b:440,d:360,th:606,v:330,z:410,w:440,y:440}

	//DEFECT need correct values for mindur
	//110=606 100=550 90=495 80=440 70=385 60=330 50=275 40=220
	//30=165
	var minimumDuration={aa:440,ae:330,ah:275,ao:440,aw:550,ay:495,eh:330,er:550,ey:385,ih:220,iy:275,ow:385,oy:606,uh:275,uw:330,l:220,r:165,m:330,n:193,ng:275,ch:275,jh:275,dh:165,f:330,s:275,sh:275,zh:220,k:275,p:275,t:220,g:275,b:275,d:220,th:220,v:220,z:220,w:330,y:220}	
	var consonants="l,r,m,n,ng,ch,jh,dh,f,s,sh,zh,k,p,t,g,b,d,th,v,z,w,y"
	var stops="ch,b,d,g,JH,k,p,t"
	var clauses=[]
	var words=[]
	var word={spelling:"",syntax:" ",pronounciations:[]} 
	var saying=""
	passage=passage.toLowerCase().replace(/\s+/g, ' ').trim().replace(" -","-").replace("- ","-").replace(" ,",",").replace(", ",",").replace(" .",".").replace(". ",".").replace(" ?","?").replace("? ","?")+"*"
	function update(char)
	{
		word.prosody=char
		words.push(word)
		return {spelling:"",prosody:" ",pronounciations:[]} 
	}
	for (let i = 0; i < passage.length; i++)
	{
	
		switch (passage[i]) 
		{
			case ".":
				word=update(".")
				break
				
			case "?":
				word=update("?")
				break  
				
			case ",":
				word=update(",")
				break
			case "-":
				word=update("-")
				break
			case " ":
				word=update(" ")
				break	
			case "*":
				if (word.spelling.length>0)
				{
					update(".")
				}
				break
			default:
				word.spelling+=passage[i]
		}
	}
	var clause=[]
	words.forEach(word=>
	{
		word.pronounciations=word.pronounciations.concat(pronouncing.phonesForWord(word.spelling))

		word.pronounciations=word.pronounciations.map(p=>p.split(" ").map(phoneme=>
			{
				return {duration:1,phoneme:phoneme.replace(/\d+/g, '').toLowerCase(),stress:phoneme.replace(/[A-Z]+/g,""),stop_consonant:stops.includes(phoneme.toLowerCase()) ? true : false,polysyllabic:pronouncing.syllableCount(p)>1}
			}))  
		clause.push(word)
		if (word.prosody==="." || word.prosody==="?" || word.prosody==="," || word.prosody==="*")
		{
			clauses.push(clause)
			clause=[]
		}
	})
	clauses.forEach(clause=>
	{
		saying+="-/" //Rule 1 add 200 ms pause for each clause
		
		clause[clause.length-1].pronounciations.forEach(p=>
		{
			for (let i = p.length -1; i >= 0; i--)
			{

				p[i].duration*=1.4//Rule 2 lengthen last syllable up to and including the vowel by 140%
				if (p[i].stress >="0"  ) break
				
			}
			
		})
		clause.forEach(word=>
		{
			word.pronounciations.forEach(p=>
			{
				p.forEach((phone)=>
				{
					if (phone.stress >="0" & phone.duration===1)  
					{
						phone.duration*=.6  //Rule 3
					}
				})
				var last=true
				for (let i = p.length -1; i >= 0; i--)
				{
		
					
					if (p[i].stress >="0")
					{
						if(last){last=false}
						else
						{

							p[i].duration*=.85 //Rule 4
						}
						if(p[i].polysyllabic) p[i].duration*=.8 //Rule 5
					} 
					if (i!==0 && consonants.includes(p[i].phoneme)) p[i].duration*=.85 //Rule 6
				}
			})
			
		})


		//Generate Speako-8 string
		clause.forEach(word=>
		{
			word.pronounciations.forEach(p=>
			{
				p.forEach(phone=>
				{
					var {phoneme,duration,stop_consonant,stress}=phone
					var d=innateDuration[phoneme]*duration
					d=d>minimumDuration[phoneme]?d:(stress=="0"?minimumDuration[phoneme]/2:minimumDuration[phoneme])
					if (stop_consonant)
					{
						var duration=d/1100
					}
					else
					{
						var duration=d/innateDuration[phoneme]
					}
					
					if (duration!==0)
					{ 
						durationText=Math.abs(Math.floor((1-duration)*100)).toString()//get digits after decimal
						if (durationText[duration.length-1]==0)durationText=durationText.slice(0,-1) //removing trailing zero
						if (duration<1){saying+="-1."+durationText+"/"}
						if (duration>1){saying+="1."+durationText+"/"}
					}
					if (phone.stop_consonant) saying+="_/"
					saying+=phone.phoneme+"/"
				})
			
			})
		})
	})
	return saying=saying.slice(0,-1).toLowerCase()



}