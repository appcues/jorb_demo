defmodule JorbDemo.Emitter do
  require Logger
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

    JorbDemo.Job.perform_async(:erlang.system_time(:milli_seconds))

    Logger.debug("Sent off an event to SQS")
    {:noreply, :ignored}
  end
end
