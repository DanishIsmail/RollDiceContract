import RollDice from 0x2736da6a6526d0de

transaction(){
    // playerOne: Address, playerTwo: Address
    prepare(signer: AuthAccount){

    }
    execute{
        RollDice.setPlayers(firstPlayer: 0x23c68575baf1b8e2, secondPlayer:0xd1f5599b320fb25c)
    }

}