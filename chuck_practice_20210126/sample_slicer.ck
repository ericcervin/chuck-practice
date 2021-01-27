//chuck_practice_20210126
//sample_slicer.ck

//master buffer
Gain mast => dac;

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[10];

spork ~ slice(happening[0],"sample6.wav",0,msToSamples(16000),0.9,"n");// all
spork ~ slice(happening[1],"sample6.wav",msToSamples(1680),msToSamples(1500),0.9,"n");// musical purposes
spork ~ slice(happening[2],"sample6.wav",msToSamples(3000),msToSamples(100),0.9,"y");// ssss
spork ~ slice(happening[3],"sample6.wav",msToSamples(3650),msToSamples(1800),0.9,"n");// any and all sounds
spork ~ slice(happening[4],"sample6.wav",msToSamples(7650),msToSamples(1100),0.9,"n");// photoelectric
spork ~ slice(happening[5],"sample6.wav",msToSamples(9200),msToSamples(800),0.9,"n");// film
spork ~ slice(happening[6],"sample6.wav",msToSamples(10600),msToSamples(580),0.9,"n");// mechanic
spork ~ slice(happening[7],"sample6.wav",msToSamples(13400),msToSamples(800),0.9,"n");// synthetic
spork ~ slice(happening[8],"sample6.wav",msToSamples(4560),msToSamples(900),0.9,"n");// sounds

tempo.wholeNote=> now;

happening[0].signal(); (16::second/0.9) => now;

while(true){
if      (counter.Measure == 13){happening[3].signal();}
else if (counter.Measure > 13) {
    if ((counter.Measure % 2) == 0){
       Math.random2(1,3) => int choice;
       if       (choice == 1){happening[4].signal();}
       else if  (choice == 2){happening[6].signal();}
       else if  (choice == 3){happening[7].signal();}
    } 
    else {
      happening[8].signal();  
    }
}

tempo.wholeNote => now;

   }

fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void slice(Event anEvent, string file, int start, int len, float rate, string has_env){
    
    SndBuf sound;
    Envelope env;
    
    if (has_env == "y"){
      sound => env => mast;
    } else {
      sound => mast;
    }
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    sound.samples() => sound.pos;
    rate => sound.rate;
    0.75 => sound.gain;
    
    while( true )
    { 
      anEvent => now;
      start => sound.pos;
        
      if (has_env == "y"){  
        1 => env.target;
        ((len * 0.5)/rate)::samp => dur rise =>  dur fall;
        rise => env.duration;
        1 => env.keyOn;
        rise=>now;
        1 => env.keyOff;
        fall=>now;
      } else {  
        (len/rate)::samp=>now;
         sound.samples() => sound.pos;
      }
    }
 }


