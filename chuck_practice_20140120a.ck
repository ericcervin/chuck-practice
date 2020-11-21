Impulse imp1 => Delay d1 => dac;
d1 => d1;
0.99 => d1.gain;
0.01::second => d1.delay;

Impulse imp2 => Delay d2 => dac;
d2 => d2;
0.99 => d2.gain;
0.0002::second => d2.delay;

[0.0,0.0,0.0,0.5,
 0.0,0.5,0.0,0.5,
 0.0,0.0,0.0,0.5,
 0.5,0.5,0.5,0.5] @=> float clickPattern[];

spork~ kick();
spork~ click();

30::second => now;

fun void kick(){
 repeat(24){
  Math.random2f(0.5,0.75) => imp1.next;
  1::second => now;
 }
}

fun void click(){
  1 => int loopCounter;

  repeat(12){
    if (loopCounter%4 == 0){
      0.0002::second => d2.delay;
    } else {
      0.0003::second => d2.delay;
    }
    for (0 => int i; i < clickPattern.cap(); i++){
      clickPattern[i] => imp2.next;
      0.125::second => now;
    }
    loopCounter++;
  }
}