defmodule PodcastquizWeb.Helpers do
  use PodcastquizWeb, :controller

  def tally_score(quiz, choice) do
    score = String.to_atom(choice)
    Map.update(quiz, score, score, &(&1 + 1))
  end

end
