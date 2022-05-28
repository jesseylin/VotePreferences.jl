using VotePreferences, LinearAlgebra
using Test

a = [1 2;
     3 4]
b = [5 6;
     7 8]
c = [5 10; 15 20;;; 7 14; 21 28;;;; 6 12; 18 24;;; 8 16; 24 32]
@testset "Kronecker" begin
    @test a ⊗ b == c
end

num_offices = 3
num_candidates = 4
prefvecs = [rand() for i in 1:num_offices, j in 1:num_candidates]
@testset "VotePreferences" begin
    vp = VotePreference(prefvecs)
    @test typeof(vp) == VotePreference
    @test mapslices(norm, vp.prefvecs; dims=1) ≈ reshape([1. for i in 1:num_candidates], (1,num_candidates))
    @test overlap(vp, vp) ≈ 1
end
