using CSV
using DelimitedFiles

#Part A
x = CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/S_array.csv")
y = CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/A_array.csv")

S = convert(Matrix, x)
A = convert(Matrix, y)

# S is stoichiometric matrix
# A is atom matrix

#Part B
check1 = transpose(A)*S

#Since check1 is not balanced, must adjust for boundary species
x_bound = CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/S_bound_array.csv")
y_bound = CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/A_bound_array.csv")

S_bound = convert(Matrix, x_bound)
A_bound = convert(Matrix, y_bound)

check2 = transpose(A_bound)*S_bound

# Part C
include("Flux.jl")

#objective: maximize urea production
c = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

#using Vmax for upper bound
fluxbound1 = convert(Matrix, CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/F_bound_array.csv"))

speciesbound = convert(Matrix, CSV.read("/Users/jash21/Desktop/CHEME-7770-Cornell-S19-79cb3531ed9014b728726d879c4c506dd5ae8d0c/src/PS_3 aj623/SPC_bound_array.csv"))

#Solve lp problem
(objective_value, flux_array, dual_array, uptake_array, exit_flag) = calculate_optimal_flux_distribution(S, fluxbound1, speciesbound, c)
maxrate = -1*objective_value
