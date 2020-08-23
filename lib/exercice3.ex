defmodule Messaging do
  use GenServer

@moduledoc """
  """

  @doc """
  
  """

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :chat)
  end

  def entrer_message(msg) do
    GenServer.cast(:chat, {:ecrire_message, msg})
  end


  def afficher_message() do
    GenServer.call( :chat , :affiche_message)
  end


    def  process_exist?() do

   pid = Process.whereis(:chat)
      if pid != nil do
    true &&  Process.alive? pid
      else
         false
      end


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
    IO.puts "shutdown the process"
    IO.inspect(state)
    :normal
  end
end
