//chuck_practice_20210201
//sample_slicer.ck

//master buffer
Gain mast => dac;

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[10];

spork ~ slice(happening[0],"sample7.wav",0,msToSamples(16000),0.9,"n");// all
spork ~ slice(happening[1],"sample7.wav",0,msToSamples(1000),0.9,"n");// any sound
spork ~ slice(happening[2],"sample7.wav",msToSamples(1100),msToSamples(1100),0.9,"n");// is acceptable
spork ~ slice(happening[3],"sample7.wav",msToSamples(3500),msToSamples(1500),0.9,"n");// percussion music
spork ~ slice(happening[4],"sample7.wav",msToSamples(7000),msToSamples(1900),0.9,"n");// academically forbidden
spork ~ slice(happening[5],"sample7.wav",msToSamples(9400),msToSamples(1000),0.9,"n");// non-musical
spork ~ slice(happening[6],"sample7.wav",msToSamples(11650),msToSamples(700),0.9,"n");//sound
spork ~ slice(happening[7],"sample7.wav",msToSamples(12500),msToSamples(800),0.9,"n");//so far
spork ~ slice(happening[8],"sample7.wav",msToSamples(13700),msToSamples(275),0.9,"n");//as
spork ~ slice(happening[9],"sample7.wav",msToSamples(14800),msToSamples(750),0.9,"n");//possible

tempo.wholeNote=> now;

happening[0].signal(); (16::second/0.9) => now;


while(true){
if ((((counter.Measure - 12) % 4) == 1)&&(counter.Measure < 28)){
  spork ~ nmssfap();   
}  

if (((counter.Measure - 12) % 2) == 0){
  happening[3].signal();  
}

tempo.wholeNote => now;

   }
   
fun void nmssfap(){
    happening[5].signal(); (1.0::second/0.9) => now;
    happening[6].signal(); (0.7::second/0.9) => now;
    happening[7].signal(); (0.8::second/0.9) => now;
    happening[8].signal(); (0.275::second/0.9) => now;
    happening[9].signal(); (0.750::second/0.9) => now;
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


