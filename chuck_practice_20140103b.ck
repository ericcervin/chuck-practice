SndBuf Buff => Envelope env => JCRev jc => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
0.8 => Buff.rate;

[10000,15000,20000,25000,30000,35000,40000] @=> int positions[];
[0.1,0.3,0.1,0.7,0.1,1.0,0.1,0.5,0.1] @=> float riseRatios[];

for (0=> int j;j < riseRatios.cap();j++){
    for (0=> int i; i < positions.cap(); i++){
        grain_train(50,positions[i],750,riseRatios[j]);
    }
    Buff.samples() => Buff.pos;
    50000::samp=>now;
   }
1::second=>now;

fun void play_grain(int position, int length, float riseRatio){
  (length::samp * riseRatio) => dur rise;
  (length::samp - rise) => dur fall;
  position => Buff.pos;
  rise => env.duration;
  1 => env.keyOn;
  rise=>now;
  1 => env.keyOff;
  fall=>now;
}

fun void grain_train(int grainCount, int position, int length, float riseRatio){
  repeat(grainCount){play_grain(position,length,riseRatio);}
}
