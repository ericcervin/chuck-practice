//chuck_practice_20201231
//different_drummer.ck

// tempo and counter objects
BPM tempo;
TheCount counter;

["tr-09-bd.wav",//0
"tr-09-bd-long.wav",
"tr-09-bd-long-low.wav",
"tr-09-bd-low.wav",
"tr-09-ch.wav",//4
"tr-09-ch-long.wav",
"tr-09-clap.wav",
"tr-09-crash.wav",
"tr-09-crash-low.wav",//8
"tr-09-ht.wav",
"tr-09-ht-long.wav",
"tr-09-ht-long-low.wav",
"tr-09-ht-low.wav",
"tr-09-lt.wav",
"tr-09-lt-long.wav",
"tr-09-lt-long-low.wav",
"tr-09-lt-low.wav",
"tr-09-mt.wav",
"tr-09-mt-long.wav",
"tr-09-mt-long-low.wav",
"tr-09-mt-low.wav",//20
"tr-09-oh.wav",
"tr-09-oh-long.wav",
"tr-09-ride.wav",
"tr-09-ride-low.wav",
"tr-09-rim.wav",
"tr-09-sd.wav",
"tr-09-sd-low.wav",
"tr-09-sd-snappy.wav",
"tr-09-sd-snappy-low.wav"] @=> string drum_files[];

drum_files.size() => int drum_count;
Event happening[drum_count];

for (0 => int i; i < drum_count; i++){
    spork ~ drum_buff(happening[i],drum_files[i], 0, 500, 0.8);
    }   

while(true){
    if ( Math.random2(1,10) < 7){ //60%
       happening[Math.random2(9,20)].signal();//just toms
    }
    tempo.sixteenthNote => now;   
    }


    
fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void drum_buff(Event anEvent, string file, int start, int len, float rate){
    SndBuf sound  => dac;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    
    
    while( true )
    {
      anEvent => now;
   
      msToSamples(start) => sound.pos;
      len::ms=>now;
      sound.samples() => sound.pos;
      
    }
 }