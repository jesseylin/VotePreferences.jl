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

@testset "VotePreferences.jl" begin
    # Write your tests here.
end
