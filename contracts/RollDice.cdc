pub contract RollDice{
    access(contract) var countShort: UInt64
    access(contract) var diceResult:{Address: UInt64}
    access(contract) var randomValues: [UInt64]
    access(contract) var countPlayerShort: {Address: UInt64}
    access(contract) var playerfirst: Address
    access(contract) var playerSecond: Address
    access(contract) var currentValue: UInt64

    init(){
        self.countShort = 0
        self.diceResult ={} 
        self.randomValues =[]
        self.countPlayerShort = {}
        self.playerfirst = 0x0
        self.playerSecond = 0x0
        self.currentValue = 0
        self.countShort = 0
    }

    pub fun setPlayers(firstPlayer: Address, secondPlayer:Address):Bool{
        pre {
            firstPlayer != nil:"please provide the first palyer adress"
            secondPlayer != nil:"please provide the second palyer adress"
            //self.playerfirst == 0x0 && self.playerSecond == 0x0 : "please wait for end of running game"
        }
        self.playerfirst = firstPlayer
        self.playerSecond = secondPlayer
        self.countPlayerShort[firstPlayer]=0
        self.countPlayerShort[secondPlayer]=0
        self.diceResult[firstPlayer]= 0
        self.diceResult[secondPlayer]= 0
        self.randomValues = []
        self.countShort = 0
        return  true   
    }

    pub fun playGame(playerAddress: Address):{Address: UInt64}{
        pre {
            playerAddress != nil:"please provide the palyer adress"
            playerAddress == self.playerfirst || playerAddress == self.playerSecond : "you are not able to play this time please try next time"
            self.countShort <=6: "game end"
            self.countPlayerShort[playerAddress]! <=3: "your turns are complete" 
        }

        var randdataValues = self.getRandomNumber()
        self.countPlayerShort[playerAddress] = self.countPlayerShort[playerAddress]!.saturatingAdd(1)
        self.countShort = self.countShort.saturatingAdd(1)
        assert(self.randomValues.contains(randdataValues) == true, message: "could not found this number")
        self.diceResult[playerAddress] = self.diceResult[playerAddress]!.saturatingAdd(randdataValues)
        if(self.countShort ==6){
            self.playerfirst = 0x0
            self.playerSecond = 0x0
            //self.countShort = 0
            self.currentValue = 0
            var diceResultData: {Address: UInt64} = self.diceResult
            // self.diceResult = {}
            self.countPlayerShort = {}
            return diceResultData
        }
        return  {}
    }
    
    pub fun getUserResult(): {Address: UInt64}{
        return  self.diceResult
    }

    pub fun getCountShort(): UInt64{
        return  self.countShort
    }

    pub fun getRandomValues(): [UInt64]{
        return  self.randomValues
    }
    access(contract) fun getRandomNumber(): UInt64{
        var randdata = unsafeRandom() % 6 + 1
         if(self.randomValues.contains(randdata) == false){
            self.randomValues.append(randdata)
            return randdata  
         }
         else{
            self.getRandomNumber()
         }
        
        return  1
    }
}