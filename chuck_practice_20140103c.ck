SndBuf Buff => JCRev jc => dac;
me.dir() + "/audio/sample2.wav" => Buff.read;
-1 => Buff.rate;
66 => int sliceCount;
Buff.samples()/sliceCount => int sliceLength;

repeat(6){
  repeat(sliceCount){
   Math.random2(0,sliceCount-1) => int sliceChoice;
  (sliceChoice * sliceLength) => Buff.pos;
   sliceLength::samp => now;
  }
  2::second => now;
}
6::second=> now;

