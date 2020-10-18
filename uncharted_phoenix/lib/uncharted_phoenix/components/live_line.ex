defmodule UnchartedPhoenix.LiveLineComponent do
  @moduledoc """
  Line Chart Component
  """

  use Phoenix.LiveComponent

  @default_width 700
  @default_height 400

  def update(assigns, socket) do
    x_axis = assigns.chart.dataset.axes.x
    y_axis = assigns.chart.dataset.axes.y
    # Hardcode the number of steps to take as 5 for now
    x_grid_lines = x_axis.grid_lines.({x_axis.min, x_axis.max}, 5)
    x_grid_line_offsetter = fn grid_line -> 100 * grid_line / x_axis.max end

    y_grid_lines = y_axis.grid_lines.({y_axis.min, y_axis.max}, 5)
    y_grid_line_offsetter = fn grid_line -> 100 * (y_axis.max - grid_line) / y_axis.max end

    socket =
      socket
      |> assign(%{
        chart: assigns.chart,
        points: Uncharted.LineChart.points(assigns.chart),
        lines: Uncharted.LineChart.lines(assigns.chart),
        x_grid_lines: x_grid_lines,
        x_grid_line_offsetter: x_grid_line_offsetter,
        x_axis: x_axis,
        y_grid_lines: y_grid_lines,
        y_grid_line_offsetter: y_grid_line_offsetter,
        width: assigns.chart.width || @default_width,
        height: assigns.chart.height || @default_height
      })

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_line.html", assigns)
  end
end
