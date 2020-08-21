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
    GenServer.start_link(__MODULE__, [])
  end

  def entrer_message(msg, pid) do
    GenServer.cast(pid, {:ecrire_message, msg})
  end


  def afficher_message(pid) do
    GenServer.call( pid , :affiche_message)
  end


  def  process_exist?(pid) do

    true &&  Process.alive?(pid)
end


  def stop(pid) do
    GenServer.call(pid, :stop)
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
  def handle_call(:stop, _from, state) do
    {:stop, :normal, :shutdown, state}
  end
end
