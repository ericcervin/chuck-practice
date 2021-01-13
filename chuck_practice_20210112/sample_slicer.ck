//chuck_practice_20210112
//sample_slicer.ck

//master buffer
Gain mast => dac;

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[4];

spork ~ slice(happening[0],"elizabeth_from_knoxville.wav",msToSamples(20200),msToSamples(1300),0.8);
spork ~ slice(happening[1],"elizabeth_from_knoxville.wav",msToSamples(23850),msToSamples(1200),0.8);
spork ~ slice(happening[2],"elizabeth_from_knoxville.wav",msToSamples(0),msToSamples(1782),0.8);
spork ~ slice(happening[3],"elizabeth_from_knoxville.wav",msToSamples(2700),msToSamples(1200),0.8);

while(true){
  if ((counter.Measure == 1 ) || (counter.Measure == 9 )){
    tempo.sixteenthNote => now;
    happening[0].signal();
    tempo.wholeNote => now;
    happening[1].signal();
  } else if ((counter.Measure == 5 ) || (counter.Measure == 13 )){
    happening[2].signal(); 
    tempo.wholeNote => now;
    happening[3].signal();  
      }
  tempo.wholeNote => now;
}

fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void slice(Event anEvent, string file, int start, int len, float rate){
    
    SndBuf sound => mast;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    sound.samples() => sound.pos;
    rate => sound.rate;
    0.75 => sound.gain;
    
    while( true )
    { 
      anEvent => now;
      start => sound.pos;
      (len/rate)::samp=>now;
      sound.samples() => sound.pos;
    }
 }


