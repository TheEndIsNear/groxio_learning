module Covid19
  using CSV, DataFrames, Query
  export data

  function data()
    raw = CSV.read("data/full_data.csv", DataFrame)
    cases = coalesce.(raw, 0.0)

    population = CSV.read("data/locations.csv", DataFrame)

    innerjoin(cases, population, on = :location)
  end
end # module
