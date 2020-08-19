defmodule Messaging do
  use GenServer

@moduledoc """
  permet de stocker les messages envoyés dans une liste
  et les afficher à la demande
  """

  @doc """
  ## Examples
      iex> Messaging.start_link
      {:ok, #PID<0.143.0>}
      iex> Messaging.add_message("Bonjour")
      :ok
      iex> Messaging.add_message("foo")
      :ok
      iex> Messaging.get_messages
      ["Bonjour, foo"]
      :world
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :chat)
  end
  def new(), do: Messaging.start_link()
  def add_message( message) do
    GenServer.cast(:chat, {:add_message, message})
  end

  def get_messages do
    GenServer.call(:chat, :get_messages)
  end
  def get_message do
    GenServer.call(:chat, :get_message)
  end

  def init(messages) do
    {:ok, messages}
  end

  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

end
