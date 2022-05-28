module VotePreferences

export ⊗
export VotePreference, overlap

using LinearAlgebra

# VotePreference object
struct VotePreference
    prefvecs
    prefstate
    num_candidates
end

"""
    Constructs VotePreference struct for an input Array of prefvecs 
    with each column as the preference vector
"""
function VotePreference(prefvecs::Array)
    # normalize
    prefvecs = prefvecs ./ mapslices(norm, prefvecs; dims=1)
    # initialize prefstate
    prefstate = prefvecs[:,1]
    # iteratively generate full prefstate
    for i in 2:size(prefvecs, 2)
        prefstate = prefstate ⊗ prefvecs[:,i]
    end

    num_candidates = size(prefvecs, 1)
    return VotePreference(prefvecs, prefstate, num_candidates)
end
function VotePreference(;prefstate=0)
    num_candidates = size(prefstate, 1)
    return VotePreference(nothing, prefstate, num_candidates)
end
    """ 
        Computes the overlap of the tensor product states
    """
function overlap(x::VotePreference, y::VotePreference)
    x = x.prefstate
    y = y.prefstate
    indices_x = [1:ndims(x)...]
    indices_y = [1:ndims(y)...]
    if indices_x != indices_y
        throw(ArgumentError("Arguments have preference states with unequal dimensionality."))
    end
    return only(ncon([x,y], [indices_x, indices_y]))
end

include("kronecker.jl")
include("fpp.jl")

end
