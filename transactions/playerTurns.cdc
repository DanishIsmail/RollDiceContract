import RollDice from 0x2736da6a6526d0de

transaction(playerAddress: Address){
    prepare(signer: AuthAccount){

    }
    execute{
        RollDice.playGame(playerAddress: playerAddress)
    }

}