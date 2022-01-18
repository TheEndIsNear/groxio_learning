{target_m, target_b} =
  {
    :rand.normal(0.0, 10.0),
    :rand.normal(0.0, 5.0)
  }

target_fn =
  fn x ->
    target_m * x + target_b
  end

build_batch = fn  ->
  xs = for _ <- 1..64, do: :rand.uniform() * 10
  ys = Enum.map(xs, target_fn)

  Enum.zip(xs, ys)
end

data = Stream.repeatedly(build_batch)

test_data = build_batch.()

{m, b} = Linear.initial_random_params()
IO.puts("Target {m, b}: {#{Nx.to_number(target_m)}, #{Nx.to_number(target_b)}}")
initial_loss = Linear.batch_loss({m, b}, test_data)
IO.puts("Initial loss: #{Nx.to_number(initial_loss)}")

{m, b} = Linear.train(50, data, {m, b})

IO.puts("Trained! Final results")

final_loss = Linear.batch_loss({m, b}, test_data)
IO.puts("Final loss: #{Nx.to_number(final_loss)}")
IO.puts("Learned {m, b}: {#{Nx.to_number(m)}, #{Nx.to_number(b)}")
