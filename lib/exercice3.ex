defmodule Messaging do
  use GenServer

@moduledoc """
  
  """

  @doc """
  ## Examples
  iex>Messaging.start_link
  {:ok, #PID<0.174.0>}
  iex>Messaging.entrer_message("Bonjour")
  :ok
  iex>Messaging.afficher_message
  ["Bonjour"]
  iex>Messaging.stop  
  shut down the process
   ["Bonjour"]
   does the Genserver exist?
** (EXIT from #PID<0.158.0>) shell process exited with reason: :ok

  """

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :chat)
  end

  def entrer_message(msg) do
    GenServer.cast(:chat, {:ecrire_message, msg})
  end

  @spec afficher_message() :: any
  def afficher_message() do
    GenServer.call( :chat , :affiche_message)
  end
  def stop() do
    GenServer.stop(:chat, :normal)
  end


  def init( message_vide) do
    {:ok, message_vide}
  end

  def handle_cast({:ecrire_message, msg}, state) do
    {:noreply, [msg | state]}
  end

  def handle_call(:affiche_message, _from, state) do
    {:reply, state, state}
  end
  def terminate(:normal, state) do
    IO.puts "shut down the process"
    IO.inspect(state)
    IO.puts"does the Genserver exist?"
    Process.whereis(:chat) |> Process.exit(:ok)
    result = Process.whereis(:chat) |>Process.alive?
    IO.puts("#{result}")

    :normal
  end
end
