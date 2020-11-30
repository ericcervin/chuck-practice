//chuck_practice_20201129
//score.ck

//paths to chuck files

me.dir() + "/kick.ck" => string kickPath; 
me.dir() + "/fm.ck" => string fmPath;
me.dir() + "/shake.ck" => string shakePath;

int fmID;//has to be declared outside the scope of the while loop

// start kickin'
Machine.add(kickPath) => int kickID;

//set time divisions to split piece into 3 aka "several distinct sections"
//section 1 kick & fm. section 2 kick & shaker. section 3 kick, shaker & fm
now + 30::second => time TheEnd;
now + 10::second => time OneThirdWay;
now + 20::second => time TwoThirdsWay;

while (now < TheEnd){ //until TheEnd
    if ((now < OneThirdWay)||(now > TwoThirdsWay)) {   //fm synth in first/last third of piece
        Machine.add(fmPath) => fmID; //multiple fm synths will overlap
    }
    if (now > OneThirdWay) {//shaker only after 10 seconds
        Machine.add(shakePath) => int shakeID; 
    }
    .625::second => now; //loop at assignment's pulse rate
}
    
Machine.remove(kickID);//stop kickin
Machine.remove(fmID);//stop lingering fm synth