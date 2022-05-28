using VotePreferences, LinearAlgebra
using Test

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
