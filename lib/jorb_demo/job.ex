defmodule JorbDemo.Job do
  require Logger

  use Jorb.Job

  def queue_name, do: Application.get_env(:jorb_demo, :queue_name)

  def perform(params) do
    Logger.debug("Hello I am performing a job with params #{params}")
    :ok
  end
end
