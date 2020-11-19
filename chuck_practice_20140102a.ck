SndBuf Buff => JCRev jc => JCRev jc2 => dac;
me.dir() + "/audio/sample2.wav" => Buff.read;
(Buff.samples() - 1) => int lastPos;
0 => Buff.pos;
0.0 => float mixlev;
mixlev => jc.mix => jc2.mix;
0 => int loopCount;

while(loopCount<20){
  if (Math.random2(1,100) > 18){
    1 => Buff.rate;
  } else {
    0 => Buff.rate;
  }
  if (Buff.pos() == lastPos){
    loopCount++;
    <<<loopCount>>>;
    0=>Buff.pos;
    if ((loopCount%4)==0){0.05 +=> mixlev; mixlev => jc.mix => jc2.mix;}
  };
  1::samp=>now;
}
8::second=>now;
