//chuck_practice_20201220
//grain_cloud.ck

//SndBuf Buff => Envelope env => JCRev jc => dac;
SndBuf Buff => Envelope env => dac;
me.dir(-1) + "/audio/sample4.wav" => Buff.read;
Buff.samples() => Buff.pos;
0.8 => Buff.rate;
2.0 => env.target;
//<<<Buff.samples()>>>;

// tempo and counter objects
BPM tempo;
TheCount counter;




while(true){
    if (counter.Measure % 2.0 == 0) {
    play_grain(Math.random2(1500,2500),tempo.sixteenthNote,0.25);
    } else {
    tempo.wholeNote => now;}
}

//grain_cloud function to spork off with a particular buff location and quality of grain


fun void play_grain(int position, dur length, float riseRatio){
  (length * riseRatio) => dur rise;
  (length - rise) => dur fall;
  msToSamples(position) => Buff.pos;
  rise => env.duration;
  1 => env.keyOn;
  rise=>now;
  1 => env.keyOff;
  fall=>now;
}

fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }