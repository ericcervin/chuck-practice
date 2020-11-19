SndBuf Buff => JCRev jc => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
0.8 => Buff.rate;

[10000,15000,20000,25000,30000,35000,40000] @=> int positions[];

repeat(8){
  for (0=> int i; i < positions.cap(); i++){
    grain_train(50,positions[i],750);
  }
  Buff.samples() => Buff.pos;
  50000::samp=>now;
}

1::second=>now;

fun void play_grain(int position, int length){
  position => Buff.pos;
  length::samp=>now;
}

fun void grain_train(int grainCount, int position, int length){
  repeat(grainCount){play_grain(position,length);}
}
