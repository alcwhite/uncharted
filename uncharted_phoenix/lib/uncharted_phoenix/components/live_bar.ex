defmodule UnchartedPhoenix.LiveBarComponent do
  @moduledoc """
  Bar Chart Component
  """

  use Phoenix.LiveComponent

  @default_width 600
  @default_height 400

  def update(assigns, socket) do
    x_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 10 for now
    grid_lines = x_axis.grid_lines.({x_axis.min, x_axis.max}, 10)

    grid_line_offsetter = fn grid_line ->
      result = 100 * grid_line / x_axis.max
      result
    end

    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:bars, Uncharted.BarChart.bars(assigns.chart))
      |> assign(:grid_lines, grid_lines)
      |> assign(:offsetter, grid_line_offsetter)
      |> assign(:width, assigns.chart.width || @default_width)
      |> assign(:height, assigns.chart.height || @default_height)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_bar.html", assigns)
  end
end
