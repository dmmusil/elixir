defmodule ArcadeWeb.Hangman do
  use Phoenix.LiveView
  use Phoenix.HTML

  def mount(%{"secret" => secret}, _session, socket) do
    socket =
      socket
      |> assign(:secret, secret)
      |> assign(:guesses, [])

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1><%= print_puzzle(assigns.secret, assigns.guesses) %></h1>

    <p>
    <%= for c <- guessables() do %>
    <span phx-key={c} phx-click='guess' phx-value-guess={c} style='cursor: pointer;'><%= c %></span>
    <% end  %>
    </p>

    <p>Guessed so far: <%= @guesses %></p>
    """
  end

  defp print_puzzle(secret, guesses) do
    Enum.map(String.codepoints(secret), fn c -> if c in guesses, do: "#{c} ", else: "_ " end)
  end

  defp guessables() do
    ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  end

  def handle_event("guess", %{"guess" => c}, socket) do
    currrnt_guesses = socket.assigns.guesses
    guesses = if c in currrnt_guesses, do: currrnt_guesses, else: currrnt_guesses ++ [c]

    socket =
      socket
      |> assign(:guesses, guesses)

    {:noreply, socket}
  end
end
