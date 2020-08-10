require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end


  def score
    # raise
    # word cant be built out of original grid
    @letters = params[:letters]
    @guess = params[:guess]
    @included = included?(@guess, @letters)
    if @included == false
      @score = "Sorry but #{@guess} can't be built out of #{@letters}"
    # if @letters.include?(@guess.sort) == false
    #   @score = "Sorry, thats not a word"
    # end
    response = open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    json = JSON.parse(response.read)
    if json["found"] == true
      @score = "Congratulations, #{@guess} is a valid word!"
      # variable that i display in viewblala
    elsif json["found"] == false
      @score = "Sorry but #{@guess} is not a valid english word"
    end
  end
end

  private
  def included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end
end
