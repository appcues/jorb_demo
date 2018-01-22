defmodule JorbDemo.Emitter do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    emit_events()
    {:ok, :ignored}
  end

  def emit_events() do
    Process.send_after(self(), :emit_events, 100)
  end

  def handle_info(:emit_events, :ignored) do
    emit_events()

    queue_name = Application.get_env(:jorb_demo, :queue_name)
    ExAws.SQS.send_message(queue_name, :erlang.system_time(:milli_seconds))

    {:noreply, :ignored}
  end
end
