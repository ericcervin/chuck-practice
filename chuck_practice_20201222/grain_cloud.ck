//chuck_practice_20201222
//grain_cloud.ck

// tempo and counter objects
BPM tempo;
TheCount counter;

Event happening[64];

for (0 => int i ; i < 64; i++){
    spork ~ slice(happening[i],"sample4.wav", Math.random2(1550,5000), 100,0.8);
    }

while (true){
    happening[Math.random2(0,63)].signal();   
    25::ms => now; 
    }
    
fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }
    
fun void slice(Event anEvent, string file, int start, int len, float rate){
    SndBuf sound => Envelope env => dac;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    
    2.0 => env.target;
    (len * 0.5)::ms => dur rise =>  dur fall;
    
    while( true )
    {
      anEvent => now;
   
      msToSamples(start) => sound.pos;
      rise => env.duration;
      1 => env.keyOn;
      rise=>now;
      1 => env.keyOff;
      fall=>now;
      sound.samples() => sound.pos;
    }
 }