class GamesController < ApplicationController
  def survivor
    render "games/cocos2d/survivor/index.html" 
  end
  def navigation
    render "games/cocos2d/navigation/build/index.html.erb" 
  end
end
