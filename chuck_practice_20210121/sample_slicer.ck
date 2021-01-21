//chuck_practice_20210121
//sample_slicer.ck

//master buffer
Gain mast => dac;

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[10];

spork ~ slice(happening[0],"sample5.wav",0,msToSamples(14250),0.9,"n");// all
spork ~ slice(happening[1],"sample5.wav",msToSamples(6122),msToSamples(8100),0.9,"n");//quartet for, etc
spork ~ slice(happening[2],"sample5.wav",msToSamples(6100),msToSamples(700),0.9,"n");//quartet
spork ~ slice(happening[3],"sample5.wav",msToSamples(8000),msToSamples(1300),0.9,"n");//explosive motor
spork ~ slice(happening[4],"sample5.wav",msToSamples(9900),msToSamples(800),0.9,"n");//wind
spork ~ slice(happening[5],"sample5.wav",msToSamples(11700),msToSamples(700),0.9,"n");//heartbeat
spork ~ slice(happening[6],"sample5.wav",msToSamples(12400),msToSamples(250),0.9,"y");//eh
spork ~ slice(happening[7],"sample5.wav",msToSamples(12800),msToSamples(250),0.9,"y");//and
spork ~ slice(happening[8],"sample5.wav",msToSamples(13000),msToSamples(1100),0.9,"n");//landslide

tempo.wholeNote=> now;

happening[0].signal(); (14.25::second/0.9) => now;

Machine.add(me.dir() + "toms_09.ck") => int tomID;

for (0 => int i; i < 256; i++){
    if (i % 16 == 0){
      happening[7].signal();   
    }
    
    if ((i - 2) % 16 == 0){
      Math.random2(0,3) => int choice;
      if      (choice == 0){happening[3].signal();}
      else if (choice == 1){happening[4].signal();}
      else if (choice == 2){happening[5].signal();}
      else if (choice == 3){happening[8].signal();}
    }
    
    if (i % 4 == 0){
      happening[6].signal();
    }
    <<<i>>>;
    tempo.sixteenthNote => now;
}

Machine.remove(tomID);

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


