using VotePreferences
using LinearAlgebra, Random
using Test

include("../src/fpp.jl")

Random.seed!(29347619235)

a = [1 2;
     3 4]
b = [5 6;
     7 8]
c = [5 10; 15 20;;; 7 14; 21 28;;;; 6 12; 18 24;;; 8 16; 24 32]
@testset "Kronecker functional test" begin
    @test a ⊗ b == c
end

const num_offices = 3
const num_candidates = 5
const num_voters = 6
@testset "VotePreferences sanity check" begin
    prefvecs = [rand() for i in 1:num_candidates, j in 1:num_offices]
    vp = VotePreference(prefvecs)
    @test typeof(vp) == VotePreference
    @test mapslices(norm, vp.prefvecs; dims=1) ≈ reshape([1. for i in 1:num_offices], (1,num_offices))
    @test overlap(vp, vp) ≈ 1
end

# tests for electoral system
@testset "castballot! sanity checks" begin
    prefvecs = [rand() for i in 1:num_candidates, j in 1:num_offices]
    voter = VotePreference(prefvecs)

	vote = castballot(voter)

	@test typeof(vote) <: Vector{<:Integer}
	@test only(size(vote)) == num_offices
	
	@test isempty(filter(x -> x > num_candidates, vote))
	@test isempty(filter(x -> x <= 0, vote))
end

@testset "countvotes! sanity checks" begin
	votes = [[rand(1:num_candidates) for i in 1:num_offices] for i in 1:num_voters]
	votes = permutedims([votes[i][j] for i in eachindex(votes), j in eachindex(votes[1])])
	counts = Array{Int}(undef, num_offices, num_candidates)
	
	countvotes!(counts, votes)
	@test typeof(counts) <: Array{<:Integer}
	@test size(counts, 1) == num_offices
	
	@test size(counts) == (num_offices, num_candidates)
	@test vec(sum(counts; dims=2)) == [num_voters for i in axes(counts, 1)]
end

@testset "determinewinner! sanity checks" begin
	votes = [[rand(1:num_candidates) for i in 1:num_offices] for i in 1:num_voters]
	votes = permutedims([votes[i][j] for i in eachindex(votes), j in eachindex(votes[1])])
	counts = Array{Int}(undef, num_offices, num_candidates)
	countvotes!(counts, votes)

	outcome = Vector{Int}(undef, num_offices)
	determinewinner!(outcome, counts)
	@test typeof(outcome) <: Vector{<:Integer}
	@test only(size(outcome)) == num_offices
	@test isempty(filter(x -> x > num_candidates, outcome))
	@test isempty(filter(x -> x <= 0, outcome))

	@test allunique(outcome)
end

#@testset "election" begin
#    election = Election(parameterdict)
#    @test typeof(election) == Election
#end