module Workspace::LosHelper
  def position_of_items(lo)
    exercises = lo.exercise.order :created_at
    introductions = lo.introduction.order :created_at
    items = Array.new

    exercises.each do |exercise|
      items << exercise
    end

    introductions.each do |introduction|
      items << introduction
    end
    
    items.sort{|a, b| a[:created_at] <=> b[:created_at]}
  end
end
