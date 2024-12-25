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
f = File.open('google-10000-english.txt', 'r')

wordarr = []

while lines = f.gets do
  wordarr << lines
end
#1

#2 FILTER WORDS BETWEEN 12 and 5 LENGTH
def filterwords(arr)
  
  return arr.filter!{|word| word.length <= 12 && word.length >= 5}

end

filterwords(wordarr)
#2

#3 RANDOM NUMBER GENORATOR

num = rand(1..wordarr.length-1)
secretword = wordarr[num]
puts secretword
#3


#4 Start Game!
guesses = 7
playerguess = []

i = 0

while i < secretword.length-1 do
  playerguess << "-"
  i += 1
end

printguess = playerguess.join("")

puts "Welcome to HANGMAN! You have 7 guesses! Good luck!"

while guesses >= 0 do
  guesschar = false
  
  puts printguess

  inputguess = gets.to_s

  printguess.split("")

  while inputguess.length > 2
    puts "Only one char"
    inputguess = gets.to_s
  end

  a = 0
  while a < secretword.length - 1 do
    if secretword[a] == inputguess[0]
      printguess[a] = inputguess[0]
      guesschar = true
    end
    a += 1
  end

  if guesschar == false
    guesses -= 1
  end

  if !printguess.include?("-")
    puts "You got it! The word was #{secretword} Congrats you win!"
    return
  end

  puts "Guesses left: #{guesses}"

end

    puts "Unlucky the actual word was: #{secretword}"

#4