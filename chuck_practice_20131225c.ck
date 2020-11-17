SndBuf Buff => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
(Buff.samples() - 1) => int lastPos;
0 => Buff.pos;
1 => Buff.loop;
0 => int chance;

while(chance < 38){
  if (Math.random2(1,100) > chance){
    1 => Buff.rate;
  } else {
    0 => Buff.rate;
  }
  1::samp=>now;
  if (Buff.pos() == lastPos){6 +=> chance;};
}
