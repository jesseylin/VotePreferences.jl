using TensorOperations

"""
    Implements usual Kronecker product operation on matrices, utilizing TensorOperations
"""
function ⊗(a, b)
	rank_a = ndims(a)
	rank_b = ndims(b)
	indices_a = Vector(1:rank_a)
	indices_b = Vector(1:rank_b) .+ rank_a

	ncon([a,b], [-indices_a, -indices_b])
end