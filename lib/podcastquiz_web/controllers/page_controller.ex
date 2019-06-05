defmodule PodcastquizWeb.PageController do

  use PodcastquizWeb, :controller

  # import PodcastquizWeb.Helpers

  defstruct(
    horror:     0,
    comedy:     0,
    trueCrime:  0,
    nonFiction: 0,
    fiction:    0,
    short:      0,
    medium:     0,
    long:       0
  )

  def new_quiz(conn, _params) do
    render(conn, "auth.html")
  end

  def create_quiz(conn, _params) do
    quiz = %PodcastquizWeb.PageController{}
    tally = tally(quiz)
    conn
    |> put_session(:quiz, quiz)
    |> firstQuestion(_params, tally: tally)
  end

  def tally(quiz) do
    %{
      horror:     quiz.horror,
      comedy:     quiz.comedy,
      trueCrime:  quiz.trueCrime,
      nonFiction: quiz.nonFiction,
      fiction:    quiz.fiction,
      short:      quiz.short,
      medium:     quiz.medium,
      long:       quiz.long
    }
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def firstQuestion(conn, _params, tally) do
    render(conn, "firstQuestion.html", tally: tally)
  end

  def tally_score(quiz, choice) do
    score = String.to_atom(choice)
    Map.update(quiz, score, score, &(&1 + 1))
  end

  def updatePage(conn, params, question) do
    IO.inspect(conn, label: "CONN")
    choice = (params["answer"]["genre"])
    tally =
      conn
      |> get_session(:quiz)
      |> tally_score(choice)
    conn = put_session(conn, :quiz, tally)
    IO.inspect(tally, label: "hello")

    render(conn, question <> ".html")
  end

  def secondQuestion(conn, params) do
    updatePage(conn, params, "secondQuestion")
  end

  def thirdQuestion(conn, params) do
   updatePage(conn, params, "thirdQuestion")
  end

  def fourthQuestion(conn, params) do
    updatePage(conn, params, "fourthQuestion")
  end

  def fifthQuestion(conn, params) do
    updatePage(conn, params, "fifthQuestion")
  end

  def sixthQuestion(conn, params) do
    updatePage(conn, params, "sixthQuestion")
  end

  def seventhQuestion(conn, params) do
    updatePage(conn, params, "seventhQuestion")
  end

  def finalQuestion(conn, params) do
    updatePage(conn, params, "finalQuestion")
  end

  def recommendation(conn, params) do
    choice = (params["answer"]["genre"])
    tally =
      conn
      |> get_session(:quiz)
      |> tally_score(choice)

    conn = put_session(conn, :quiz, tally)

    tallyMap = Map.from_struct(tally)

    score = tallyMap |> Enum.max_by(fn {_,v} -> v end) |> elem(0)

    render_recommendation(conn, params, score)

    IO.inspect(tally, label: "helloEnd")
    IO.inspect(score, label: "jabroni")
  end


  def render_recommendation(conn, _params, score) do
    recommendation = Atom.to_string(score)
    render(conn, recommendation <> ".html")
  end

end
