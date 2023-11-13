require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @word = params[:word]
    word = @word.split('')
    @game_letters = params[:letters]
    game_letters = @game_letters.gsub(/\s+/, '').chars

    base_url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(base_url).read
    dictionary_words = JSON.parse(dictionary)
    if dictionary_words["found"] == false
      @answer = "It's not a word"

    elsif checker(game_letters, word) == false
      @answer = "Sorry the letters are not in the grid"
    else
      @answer = "Congrats! I's a word!"
    end



  end

  def checker(game_letters, word)
    word.each do |letter|
      if game_letters.include?(letter)
        game_letters.delete_at(game_letters.find_index(letter))
      else
        return false
      end
    return true
  end




  end
end
