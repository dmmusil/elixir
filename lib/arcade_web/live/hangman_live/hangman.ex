defmodule ArcadeWeb.Hangman do
  use Phoenix.LiveView

  def mount(%{"secret" => secret}, _session, socket) do
    socket =
      socket
      |> assign(:secret, secret)
      |> assign(:guesses, [])
      |> assign(:misses, 0)
      |> assign(:status, "")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container">
      <h1><%= print_puzzle(assigns.secret, assigns.guesses) %></h1>

      <p>
        <%= for c <- guessables() do %>
          <span phx-key={c} phx-click='guess' phx-value-guess={c} style='cursor: pointer;'><%= c %></span>
        <% end  %>
      </p>

      <p><%= @status %></p>
      <p>Guessed so far: <%= @guesses %></p>
      <p>Incorrect guesses: <%= @misses %></p>
    </div>
    """
  end

  defp print_puzzle(secret, guesses) do
    Enum.map(String.codepoints(secret), fn c -> if c in guesses, do: "#{c} ", else: "_ " end)
  end

  defp guessables() do
    ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  end

  def handle_event("guess", _, %{assigns: %{misses: misses}} = socket) when misses >= 4 do
    {:noreply, assign(socket, :status, "Game over")}
  end

  def handle_event("guess", %{"guess" => c}, socket) do
    current_guesses = socket.assigns.guesses

    misses =
      case c in String.codepoints(socket.assigns.secret) do
        true -> socket.assigns.misses
        _ -> socket.assigns.misses + 1
      end

    guesses = if c in current_guesses, do: current_guesses, else: current_guesses ++ [c]

    {:noreply, assign(socket, %{:guesses => guesses, :misses => misses})}
  end
end
