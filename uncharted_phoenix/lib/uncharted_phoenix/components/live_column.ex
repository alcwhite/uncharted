defmodule UnchartedPhoenix.LiveColumnComponent do
  @moduledoc """
  Column Chart Component
  """

  use Phoenix.LiveComponent

  @default_width 700
  @default_height 400

  def update(assigns, socket) do
    y_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 5 for now
    grid_lines = y_axis.grid_lines.({y_axis.min, y_axis.max}, 5)
    grid_line_offsetter = fn grid_line -> 100 * (y_axis.max - grid_line) / y_axis.max end

    socket =
      socket
      |> assign(%{
        chart: assigns.chart,
        columns: Uncharted.ColumnChart.columns(assigns.chart),
        grid_lines: grid_lines,
        grid_line_offsetter: grid_line_offsetter,
        axis: y_axis,
        width: assigns.chart.width || @default_width,
        height: assigns.chart.height || @default_height
      })

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_column.html", assigns)
  end
end
