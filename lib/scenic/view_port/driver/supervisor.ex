#
#  Created by Boyd Multerer on 10/07/17.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

defmodule Scenic.ViewPort.Driver.Supervisor do
  use Supervisor
  alias Scenic.ViewPort.Driver

  @name       :drivers

#  import IEx

  #============================================================================
  # setup the viewport supervisor - get the list of drivers from the config

  def start_link( ) do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init( :ok ) do
    Application.get_env(:scenic, Scenic)[:drivers]
    |> Enum.map( fn({driver, args}) ->
      Supervisor.child_spec({Driver, {driver, args}}, id: driver)
    end)
    |> Supervisor.init( strategy: :one_for_one )
  end

end