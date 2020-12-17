//chuck_practice_20201216
//grain_chain.ck

SndBuf Buff => Envelope env => JCRev jc => dac;
me.dir(-1) + "/audio/sample2.wav" => Buff.read;
0.8 => Buff.rate;

// tempo and counter objects
BPM tempo;
TheCount counter;

[10000,15000,20000,25000,30000,15000,35000,45000] @=> int positions[];//

//for (0=> int j;j < riseRatios.cap();j++){
while(counter.Measure <= 32){
    for (0=> int i; i < positions.cap(); i++){
        grain_chain(32,positions[i],BPM.thirtysecondNote,0.7);
    }
    Buff.samples() => Buff.pos;
}
    //50000::samp=>now;
//   }
8 * BPM.wholeNote=>now;

fun void play_grain(int position, dur length, float riseRatio){
  (length * riseRatio) => dur rise;
  (length - rise) => dur fall;
  position => Buff.pos;
  rise => env.duration;
  1 => env.keyOn;
  rise=>now;
  1 => env.keyOff;
  fall=>now;
}

fun void grain_chain(int grainCount, int position, dur length, float riseRatio){
  repeat(grainCount){play_grain(position,length,riseRatio);}
}
