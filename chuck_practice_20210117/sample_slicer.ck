//chuck_practice_20210117
//sample_slicer.ck

//master buffer
Gain mast => dac;

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[10];

spork ~ slice(happening[0],"sample5.wav",0,msToSamples(14250),0.9,"n");// all
spork ~ slice(happening[1],"sample5.wav",msToSamples(684),msToSamples(2300),0.9,"n");//four film phonographs
spork ~ slice(happening[2],"sample5.wav",msToSamples(665),msToSamples(450),0.9,"n");//four
spork ~ slice(happening[3],"sample5.wav",msToSamples(1200),msToSamples(450),0.9,"n");//film
spork ~ slice(happening[4],"sample5.wav",msToSamples(1800),msToSamples(1200),0.9,"n");//phonographs
spork ~ slice(happening[5],"sample5.wav",msToSamples(694),msToSamples(150),0.9,"y");//fo
spork ~ slice(happening[6],"sample5.wav",msToSamples(1200),msToSamples(150),0.9,"y");//fi
spork ~ slice(happening[7],"sample5.wav",msToSamples(1800),msToSamples(150),0.9,"y");//pho

tempo.wholeNote=> now;
happening[0].signal();
(14.25::second/0.9) => now;
happening[1].signal();
(2.3::second/0.9) => now;

happening[2].signal();
(.45::second/0.9) => now;
happening[3].signal();
(.45::second/0.9) => now;
happening[4].signal();
(1.2::second/0.9) => now;

for (0 => int i; i < 320; i++){
    if (i % 2 == 0){
      happening[Math.random2(5,7)].signal();
    }
    if (i % 16 == 0){
      happening[Math.random2(2,4)].signal();  
    }
    tempo.sixteenthNote => now;
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


