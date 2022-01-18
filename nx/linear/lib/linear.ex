defmodule Linear do
  import Nx.Defn

  @learning_rate 0.01

  defn predict({m, b}, x) do
    Nx.dot(m, x) + b
  end

  defn loss({_m, _b} = params, x, y) do
    predicted_y = predict(params, x)

    (y - predicted_y)
    |> Nx.power(2)
    |> Nx.mean()
  end

  defn update({m, b} = params, prediction, actual) do
    {gradient_m, gradient_b} = grad(params, &loss(&1, prediction, actual))

    {
      m - gradient_m * @learning_rate,
      b - gradient_b * @learning_rate
    }
  end

  defn initial_random_params do
    {
      Nx.random_normal({}, 0.0, 0.1),
      Nx.random_normal({}, 0.0, 0.1)
    }
  end

  def train(epochs, data, params \\ initial_random_params()) do
    for _epoch <- 1..epochs, reduce: params do
      acc ->
        batch = Enum.take(data, 200)
        Enum.reduce(batch, acc, &train_batch/2)
    end
  end

  def batch_loss(params, batch) do
    {x, y} = Enum.unzip(batch)
    loss(params, Nx.tensor(x), Nx.tensor(y))
  end

  defp train_batch(batch, params) do
    {input, target} = Enum.unzip(batch)

    update(params, Nx.tensor(input), Nx.tensor(target))
  end
end
