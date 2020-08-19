defmodule Exercice3Test do
  use ExUnit.Case
  setup do
    {:ok, pid} = Messaging.new()
    %{pid: pid}
  end


test "new/0 creates a new list", %{pid: pid}  do
  assert Process.info(pid)
end
test "add_messages/1 adds a message the messages'list" do
  assert Messaging.add_message("msg") ==:ok
end
test "get_messages/0 shows the added messages" do
  assert Messaging.get_messages() == []
end



end
