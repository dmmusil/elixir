defmodule ArcadeWeb.Wordle do
  use Phoenix.LiveView
  use Phoenix.HTML

  def mount(%{"word" => "play"}, _session, socket) do
    {:ok,
     socket
     |> assign(Arcade.Wordle.Dictionary.random() |> setup())}
  end

  def mount(%{"word" => word}, _session, socket) do
    {:ok,
     socket
     |> assign(setup(word))}
  end

  defp setup(word) do
    %{
      guess1: "",
      guess2: "",
      guess3: "",
      guess4: "",
      guess5: "",
      guess6: "",
      result1: empty_result(),
      result2: empty_result(),
      result3: empty_result(),
      result4: empty_result(),
      result5: empty_result(),
      result6: empty_result(),
      current_guess: 1,
      word: word,
      style: "display: none"
    }
  end

  defp empty_result() do
    [
      "#cccccc",
      "#cccccc",
      "#cccccc",
      "#cccccc",
      "#cccccc"
    ]
  end

  def render(assigns) do
    ~H"""
    <div class="container" phx-window-keyup="interact">
      Press enter to submit a guess after entering 5 letters
      <.render_guess guess={@guess1} result={@result1}/>
      <.render_guess guess={@guess2} result={@result2}/>
      <.render_guess guess={@guess3} result={@result3}/>
      <.render_guess guess={@guess4} result={@result4}/>
      <.render_guess guess={@guess5} result={@result5}/>
      <.render_guess guess={@guess6} result={@result6}/>
      <p style={@style}>Answer was <%= @word %></p>
    </div>
    """
  end

  def render_guess(assigns) do
    guess = assigns.guess
    result = assigns.result

    ~H"""
      <p>
        <.cell letter={String.at(guess,0)} result={Enum.at(result, 0)}/>
        <.cell letter={String.at(guess,1)} result={Enum.at(result, 1)}/>
        <.cell letter={String.at(guess,2)} result={Enum.at(result, 2)}/>
        <.cell letter={String.at(guess,3)} result={Enum.at(result, 3)}/>
        <.cell letter={String.at(guess,4)} result={Enum.at(result, 4)}/>
      </p>
    """
  end

  defp cell(assigns) do
    letter =
      case assigns.letter do
        nil -> "&nbsp;"
        _ -> assigns.letter
      end

    bg_color =
      case assigns.result do
        :correct -> "#00ff00"
        :present -> "#ffff00"
        _ -> "#cccccc"
      end

    style =
      "background-color: #{bg_color}; width: 2em; font-size: 2em; display: inline-block; text-align: center; v-align: bottom"

    ~H"""
    <span style={style}><%= raw letter %></span>
    """
  end

  def handle_event("interact", %{"key" => key}, socket) do
    IO.inspect(key)

    socket =
      socket
      |> handle_alpha(String.match?(key, ~r/^[[:alpha:]]$/), key)
      |> handle_backspace(key == "Backspace")
      |> handle_submit(key == "Enter")

    {:noreply, socket}
  end

  defp handle_alpha(socket, false, _), do: socket

  defp handle_alpha(socket, true, key) do
    %{key: guess_key, value: guess} = current_guess(socket)

    case String.length(guess) do
      5 ->
        socket

      _ ->
        socket
        |> assign(guess_key, guess <> key)
    end
  end

  defp handle_backspace(socket, false), do: socket

  defp handle_backspace(socket, true) do
    %{key: key, value: guess} = current_guess(socket)

    case String.length(guess) do
      0 ->
        socket

      _ ->
        assign(
          socket,
          key,
          String.slice(guess, 0, String.length(guess) - 1)
        )
    end
  end

  defp handle_submit(socket, false), do: socket

  defp handle_submit(socket, true) do
    %{value: value} = current_guess(socket)
    guess_length = String.length(value)

    case guess_length do
      5 ->
        case Arcade.Wordle.Dictionary.valid_guess?(value) do
          true ->
            result = Arcade.Wordle.evaluate_guess(socket.assigns.word, value)
            current_guess_key = current_guess_key(socket)

            socket
            |> update(:current_guess, &(&1 + 1))
            |> assign(String.to_atom("result#{current_guess_key}"), result)
            |> update(:style, &if(current_guess_key == 6, do: "", else: &1))

          false ->
            assign(socket, String.to_atom("guess#{current_guess_key(socket)}"), "")
        end

      _ ->
        socket
    end
  end

  defp current_guess(socket) do
    key = String.to_atom("guess#{current_guess_key(socket)}")
    IO.inspect(key)
    %{key: key, value: Map.get(socket.assigns, key)}
  end

  defp current_guess_key(socket) do
    socket.assigns.current_guess
  end
end
