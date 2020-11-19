SndBuf Buff => Envelope env => JCRev jc => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
16 => int sliceCount;
16 => int grainsPerSlice;
0=> Buff.rate;
0.1 => jc.mix;

Buff.samples()/sliceCount => int sliceLength;
sliceLength/grainsPerSlice => int grainLength;

playBuff(0,0);
1::second => now;
playBuff(0,1);
1::second => now;
playBuff(1,0);
1::second => now;
playBuff(1,1);
6::second => now;

fun void playBuff(int randomS, int randomG){
  for (0 => int j; j < sliceCount; j++){
    int sliceChoice;
    if (randomS == 1){
      Math.random2(0,sliceCount-1) => sliceChoice;
    } else {
       j => sliceChoice;
    }
    (sliceChoice * sliceLength) => int sliceStart;
     play_slice(sliceStart,randomG);
    (sliceLength/4)::samp => now;
  }
}

fun void play_slice(int sliceStart, int randomG){
  int grainChoice;
  for (0 => int i; i < grainsPerSlice; i++){
    if (randomG == 1){
      Math.random2(0,grainsPerSlice) => grainChoice;
    } else {
      i => grainChoice;
    }
    sliceStart + (grainChoice * grainLength) => int grainStart;
    play_grain(grainStart,grainLength,0.5);
  }
}

fun void play_grain(int position, int length, float riseRatio){
  1 => Buff.rate;
  (length::samp * riseRatio) => dur rise;
  (length::samp - rise) => dur fall;
  position => Buff.pos;
  rise => env.duration;
  1 => env.keyOn;
  rise=>now;
  1 => env.keyOff;
  fall=>now;
  0=> Buff.rate;
}
