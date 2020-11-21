Impulse imp => JCRev jc => dac;
0.2 => jc.mix;
for (0 => int j; j < 20; j++){
  Math.random2(10,100) => int chance;
  <<<"Chance:",chance,"%">>>;
  for (0 => int i; i < 100; i++){
    if (Math.random2(1,100) < chance){
      Math.random2f(0.1,1.0) => imp.next;
    }
    10::ms=> now;
  }
}
5::second => now;
