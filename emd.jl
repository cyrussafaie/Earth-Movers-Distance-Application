using JuMP
using HiGHS
using CSV
using DataFrames
using Printf

# --- Load data from CSV ---
data_dir = joinpath(@__DIR__, "data")

origins_df = CSV.read(joinpath(data_dir, "origins.csv"), DataFrame)
destinations_df = CSV.read(joinpath(data_dir, "destinations.csv"), DataFrame)
costs_df = CSV.read(joinpath(data_dir, "costs.csv"), DataFrame)

ORIG = origins_df.city
supply = origins_df.supply

DEST = destinations_df.city
population = destinations_df.population
demand = population .* 0.2

cost = Matrix(costs_df[:, 2:end])

n_orig = length(ORIG)
n_dest = length(DEST)

# --- Supply/demand summary ---
total_supply = sum(supply)
total_demand = round(Int64, sum(demand))
remaining = total_supply - total_demand

println("$total_supply people need to be evacuated from $n_orig cities and moved to $n_dest cities, which can host $total_demand people.")
if remaining > 0
    println("Due to limited capacity, $remaining people will not be evacuated.")
end

# --- Build model ---
m = Model(HiGHS.Optimizer)
set_silent(m)

@variable(m, Trans[i=1:n_orig, j=1:n_dest] >= 0)

@constraint(m, [i=1:n_orig], sum(Trans[i, j] for j in 1:n_dest) <= supply[i])

@constraint(m, [j=1:n_dest], sum(Trans[i, j] for i in 1:n_orig) == demand[j])

@objective(m, Min, sum(cost[i, j] * Trans[i, j] for i in 1:n_orig, j in 1:n_dest))

# --- Solve ---
println("Solving transportation problem...")
optimize!(m)

# --- Output results ---
if termination_status(m) == OPTIMAL
    @printf("Optimal!\n")
    @printf("Objective value: %d\n", objective_value(m))
    println("Transportation plan:")

    results = DataFrame(
        Origin = String[],
        Destination = String[],
        People = Int64[]
    )
    for i in 1:n_orig
        for j in 1:n_dest
            v = value(Trans[i, j])
            if v > 0.5
                push!(results, (ORIG[i], DEST[j], round(Int64, v)))
            end
        end
    end

    CSV.write("results.csv", results)
    println("Results written to results.csv ($(nrow(results)) nonzero shipments)")
    @printf("Total transported: %d\n", sum(results.People))
else
    println("No solution: $(termination_status(m))")
end
