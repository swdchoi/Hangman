#PSEUDO CODE FOR HANGMAN
#1 Open the CSV file and organise the words into an array
#2 Filter the words to 5-12 words
#3 Create a random selection generator
#4 Start game with - - - - - - - (length == word selected)
#5 Create a number of guesses to track how many times they can guess
#6 Create an input where player an input 1 char of guess
#7 Minus 1 from guess
#8 Go through secret character and if secrect character inclues char print char in the places where seen
  ## make sure if more than 1 char you print all
#9 if ALL - doesn't exist and guess is > 0 Player win
#10 OR if - exists and guess is = 0 Player lose (reveal word)

#1 OPEN CSV AND PUT IN ARR

require 'json'

class Game
  
  def initialize
    @wordarr = []
    @playerguess = []
    @secretword = []
    @guesses = 7
  end

  def getFile
    f = File.open('google-10000-english.txt', 'r')

    while lines = f.gets do
    @wordarr << lines
    end

    @wordarr.filter!{|word| word.length <= 12 && word.length >= 5}
  end

  def randomnumgen
    num = rand(1..@wordarr.length-1)
    @secretword = @wordarr[num]
  end

  def wordguessinitial
    i = 0
    while i < @secretword.length-1 do
      @playerguess << "-"
      i += 1
    end
  end

  def gamestart

    if File.exist?("savegame.json")
      puts "Do you want to load previous game? (yes or no)"
      answer = gets.chomp
      if answer == "yes"
        loadgame
      else
        getFile
        randomnumgen
        wordguessinitial
      end
    else
      getFile
      randomnumgen
      wordguessinitial
    end

    printguess = @playerguess.join("")

    puts "Welcome to HANGMAN! You have #{@guesses} guesses! Good luck!"

    while @guesses >= 0 do
      printguess = @playerguess.join("")
      guesschar = false
      
      puts printguess

      inputguess = gets.chomp

      if inputguess == "save"
        savegame
      end

      while inputguess.length > 2
        puts "Only one char"
        inputguess = gets.to_s
      end

      a = 0
      while a < @secretword.length - 1 do
        if @secretword[a] == inputguess[0]
          @playerguess[a] = inputguess[0]
          guesschar = true
        end
        a += 1
      end

      if guesschar == false
        @guesses -= 1
      end

      if !@playerguess.include?("-")
        puts "You got it! The word was #{@secretword} Congrats you win!"
        return
      end

      puts "Guesses left: #{@guesses}"

    end

    puts "Unlucky the actual word was: #{@secretword}"
    
  end

  def savegame
    savedata = {
      wordarr: @wordarr,
      playerguess: @playerguess,
      secretword: @secretword,
      guesses: @guesses,
    }.to_json

    File.open("savegame.json", "w") do |file|
      file.write(savedata)
    end
  end

  def loadgame
    if File.exist?("savegame.json")
      save_data = JSON.parse(File.read("savegame.json"), symbolize_names: true)
      @wordarr = save_data[:wordarr]
      @playerguess = save_data[:playerguess]
      @secretword = save_data[:secretword]
      @guesses = save_data[:guesses]
    return true
    else
    return false
    end
  end
end

game = Game.new
game.gamestart




